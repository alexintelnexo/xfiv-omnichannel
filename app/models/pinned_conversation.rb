# == Schema Information
#
# Table name: pinned_conversations
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :integer          not null
#  assignee_id     :integer          not null
#  conversation_id :integer          not null
#
# Indexes
#
#  index_pinned_conversations_on_assignee_id      (assignee_id)
#  index_pinned_conversations_on_conversation_id  (conversation_id)
#
class PinnedConversation < ApplicationRecord
  belongs_to :conversation
  belongs_to :account
  belongs_to :assignee, class_name: 'User'
end
