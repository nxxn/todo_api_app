class AddTaggingsIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :taggings, [ :tag_id, :task_id ], unique: true
  end
end
