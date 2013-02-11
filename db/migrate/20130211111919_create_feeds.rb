class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      #["id", "from", "story", "story_tags", "actions", "privacy", "type", "status_type", "created_time", "updated_time", "comments"]
      t.references :user
      t.string :feed_id
      t.string :story
      t.string :feed_creation_time
      t.string :comment_count

      t.timestamps
    end
  end
end
