class CreatePinnedConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :pinned_conversations do |t|
      t.integer 'account_id', null: false
      t.integer 'assignee_id', null: false
      t.integer 'conversation_id', null: false
      t.timestamps
      t.index ['assignee_id'], name: 'index_pinned_conversations_on_assignee_id'
      t.index ['conversation_id'], name: 'index_pinned_conversations_on_conversation_id'
    end
  end
end
