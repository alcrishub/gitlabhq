# frozen_string_literal: true

class AddIndexToMergeRequestReviewersUpdatedStateByUserId < Gitlab::Database::Migration[1.0]
  disable_ddl_transaction!

  INDEX_NAME = 'index_on_merge_request_reviewers_updated_state_by_user_id'

  def up
    add_concurrent_index :merge_request_reviewers, :updated_state_by_user_id, name: INDEX_NAME
  end

  def down
    remove_concurrent_index_by_name :merge_request_reviewers, INDEX_NAME
  end
end
