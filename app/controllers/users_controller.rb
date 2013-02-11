class UsersController < ApplicationController

  def index
  end

  def update_fb_status
    @id = current_user.facebook_uid
    @graph = Koala::Facebook::GraphAPI.new(current_user.access_token)
    @graph.put_wall_post(params[:status],{:name => 'ad'},@id)
    render :json => true
  end
end
