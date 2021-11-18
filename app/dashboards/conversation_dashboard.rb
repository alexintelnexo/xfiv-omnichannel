require "administrate/base_dashboard"

class ConversationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    # taggings: Field::HasMany,
    # base_tags: Field::HasMany,
    # label_taggings: Field::HasMany,
    # labels: Field::HasMany,
    account: Field::BelongsTo,
    inbox: Field::BelongsTo,
    assignee: Field::BelongsTo,
    contact: Field::BelongsTo,
    contact_inbox: Field::BelongsTo,
    team: Field::BelongsTo,
    campaign: Field::BelongsTo,
    messages: Field::HasMany,
    csat_survey_response: Field::HasOne,
    notifications: Field::HasMany,
    pinned_conversation: Field::HasOne,
    id: Field::Number,
    status: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    display_id: Field::Number,
    contact_last_seen_at: Field::DateTime,
    agent_last_seen_at: Field::DateTime,
    additional_attributes: Field::String.with_options(searchable: false),
    uuid: Field::String,
    identifier: Field::String,
    last_activity_at: Field::DateTime,
    snoozed_until: Field::DateTime,
    custom_attributes: Field::String.with_options(searchable: false),
    assignee_last_seen_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    account
    inbox
    assignee
    contact
    contact_inbox
    team
    campaign
    messages
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    account
    inbox
    assignee
    contact
    contact_inbox
    team
    campaign
    messages
    csat_survey_response
    notifications
    pinned_conversation
    id
    status
    created_at
    updated_at
    display_id
    contact_last_seen_at
    agent_last_seen_at
    additional_attributes
    uuid
    identifier
    last_activity_at
    snoozed_until
    custom_attributes
    assignee_last_seen_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    account
    inbox
    assignee
    contact
    contact_inbox
    team
    campaign
    messages
    csat_survey_response
    notifications
    pinned_conversation
    status
    display_id
    contact_last_seen_at
    agent_last_seen_at
    additional_attributes
    uuid
    identifier
    last_activity_at
    snoozed_until
    custom_attributes
    assignee_last_seen_at
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

  # Overwrite this method to customize how conversations are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(conversation)
  #   "Conversation ##{conversation.id}"
  # end
end
