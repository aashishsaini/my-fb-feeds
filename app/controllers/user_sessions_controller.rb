class UserSessionsController < ApplicationController
  def new
    if !current_user
      @user_session = UserSession.new
    else
      redirect_to users_url
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Successfully Logout!"
    redirect_to :controller => "user_sessions", :action => "new"
  end
end
