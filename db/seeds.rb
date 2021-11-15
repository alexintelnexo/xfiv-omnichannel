# loading installation configs
GlobalConfig.clear_cache
ConfigLoader.new.process

## Seeds productions
if Rails.env.production?
  # Setup Onboarding flow
  ::Redis::Alfred.set(::Redis::Alfred::CHATWOOT_INSTALLATION_ONBOARDING, true)
  SuperAdmin.create!(email: 'azambrano@intelnexo.com', password: 'AdminIntel1%')
end

## Seeds for Local Development
unless Rails.env.production?
  SuperAdmin.create!(email: 'john@acme.inc', password: 'Password1!')
  SuperAdmin.create!(email: 'pzambrano@intelnexo.com', password: 'Aaaaaa1%')

  account = Account.create!(
    name: 'Acme Inc'
  )

  account2 = Account.create!(
    name: 'intelnexo Inc'
  )


  secondary_account = Account.create!(
    name: 'Acme Org'
  )

  secondary_account2 = Account.create!(
    name: 'intelnexo Org'
  )


  user = User.new(name: 'John', email: 'john@acme.inc', password: 'Password1!')
  user.skip_confirmation!
  user.save!

  user2 = User.new(name: 'Pablo', email: 'pzambrano@intelnexo.com', password: 'Aaaaaa1%')
  user2.skip_confirmation!
  user2.save!

  AccountUser.create!(
    account_id: account.id,
    user_id: user.id,
    role: :administrator
  )

  AccountUser.create!(
    account_id: secondary_account.id,
    user_id: user.id,
    role: :administrator
  )

  AccountUser.create!(
    account_id: account2.id,
    user_id: user2.id,
    role: :administrator
  )

  AccountUser.create!(
    account_id: secondary_account2.id,
    user_id: user2.id,
    role: :administrator
  )

  # Enables creating additional accounts from dashboard
  installation_config = InstallationConfig.find_by(name: 'CREATE_NEW_ACCOUNT_FROM_DASHBOARD')
  installation_config.value = true
  installation_config.save!
  GlobalConfig.clear_cache

  web_widget = Channel::WebWidget.create!(account: account, website_url: 'https://acme.inc')

  inbox = Inbox.create!(channel: web_widget, account: account, name: 'Acme Support')
  InboxMember.create!(user: user, inbox: inbox)

  contact = Contact.create!(name: 'jane', email: 'jane@example.com', phone_number: '+2320000', account: account)
  contact_inbox = ContactInbox.create!(inbox: inbox, contact: contact, source_id: user.id, hmac_verified: true)
  conversation = Conversation.create!(
    account: account,
    inbox: inbox,
    status: :open,
    assignee: user,
    contact: contact,
    contact_inbox: contact_inbox,
    additional_attributes: {}
  )

  # sample email collect
  WootMessageSeeder.create_sample_email_collect_message conversation

  Message.create!(content: 'Hello', account: account, inbox: inbox, conversation: conversation, message_type: :incoming)

  # sample card
  WootMessageSeeder.create_sample_cards_message conversation
  # input select
  WootMessageSeeder.create_sample_input_select_message conversation
  # form
  WootMessageSeeder.create_sample_form_message conversation
  # articles
  WootMessageSeeder.create_sample_articles_message conversation
  # csat
  WootMessageSeeder.create_sample_csat_collect_message conversation

  CannedResponse.create!(account: account, short_code: 'start', content: 'Hello welcome to chatwoot.')
end
