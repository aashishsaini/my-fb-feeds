class Feed < ActiveRecord::Base
  attr_accessible :feed_id, :story, :feed_creation_time, :comment_count, :user_id
  belongs_to :user
end
