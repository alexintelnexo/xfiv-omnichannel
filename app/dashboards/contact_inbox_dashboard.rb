require "administrate/base_dashboard"

class ContactInboxDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    contact: Field::BelongsTo,
    inbox: Field::BelongsTo,
    conversations: Field::HasMany,
    id: Field::Number,
    source_id: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    hmac_verified: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    contact
    inbox
    conversations
    id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    contact
    inbox
    conversations
    id
    source_id
    created_at
    updated_at
    hmac_verified
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    contact
    inbox
    conversations
    source_id
    hmac_verified
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

  # Overwrite this method to customize how contact inboxes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(contact_inbox)
  #   "ContactInbox ##{contact_inbox.id}"
  # end
end
