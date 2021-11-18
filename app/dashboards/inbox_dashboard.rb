require "administrate/base_dashboard"

class InboxDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    events: Field::HasMany,
    avatar_attachment: Field::HasOne,
    avatar_blob: Field::HasOne,
    working_hours: Field::HasMany,
    account: Field::BelongsTo,
    channel: Field::Polymorphic,
    campaigns: Field::HasMany,
    contact_inboxes: Field::HasMany,
    contacts: Field::HasMany,
    inbox_members: Field::HasMany,
    members: Field::HasMany,
    conversations: Field::HasMany,
    messages: Field::HasMany,
    agent_bot_inbox: Field::HasOne,
    agent_bot: Field::HasOne,
    webhooks: Field::HasMany,
    hooks: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    enable_auto_assignment: Field::Boolean,
    greeting_enabled: Field::Boolean,
    greeting_message: Field::String,
    email_address: Field::String,
    working_hours_enabled: Field::Boolean,
    out_of_office_message: Field::String,
    timezone: Field::String,
    enable_email_collect: Field::Boolean,
    csat_survey_enabled: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    events
    avatar_attachment
    avatar_blob
    working_hours
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    events
    avatar_attachment
    avatar_blob
    working_hours
    account
    channel
    campaigns
    contact_inboxes
    contacts
    inbox_members
    members
    conversations
    messages
    agent_bot_inbox
    agent_bot
    webhooks
    hooks
    id
    name
    created_at
    updated_at
    enable_auto_assignment
    greeting_enabled
    greeting_message
    email_address
    working_hours_enabled
    out_of_office_message
    timezone
    enable_email_collect
    csat_survey_enabled
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    events
    avatar_attachment
    avatar_blob
    working_hours
    account
    channel
    campaigns
    contact_inboxes
    contacts
    inbox_members
    members
    conversations
    messages
    agent_bot_inbox
    agent_bot
    webhooks
    hooks
    name
    enable_auto_assignment
    greeting_enabled
    greeting_message
    email_address
    working_hours_enabled
    out_of_office_message
    timezone
    enable_email_collect
    csat_survey_enabled
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how inboxes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(inbox)
  #   "Inbox ##{inbox.id}"
  # end
end
