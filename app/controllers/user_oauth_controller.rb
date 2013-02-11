class UserOauthController < ApplicationController
  def create
    @user = User.find_or_create_from_oauth(auth_hash)
    current_user = @user
    if current_user
      UserSession.create(current_user, true)
        if current_user.facebook_uid
          @id = current_user.facebook_uid
        end
      update_user_feeds
      redirect_to users_path
    else
      redirect_to root_url, :flash => {:error => "Not authorized"}
    end
  end
  
  def failure
    redirect_to root_url, :flash => {:error => "Not authorized. #{params[:message]}"}
  end

  protected

  def update_user_feeds
    current_user.clear_feeds
    @graph = Koala::Facebook::GraphAPI.new(current_user.access_token)
    @feeds = @graph.get_connections("me", "feed")
    @feeds.each do |feed|
      Feed.create(:user_id => current_user.id,:feed_id => feed['id'], :story => feed['story'], :feed_creation_time => feed['created_time'], :comment_count => feed['comments']['count'])
    end
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
