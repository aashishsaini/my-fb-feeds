Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :facebook, "#{APP_CONFIG['FB_APP_ID']}", "#{APP_CONFIG['FB_SECRET']}", {:scope => 'publish_stream,email,user_birthday,read_stream,user_relationships', :display => 'popup'}
end
OmniAuth::Strategies::OAuth2.class_eval do
  def callback_phase
    if request.params['error'] || request.params['error_reason']
      redirect "/user_sessions/new"
    else
      self.access_token = build_access_token
      self.access_token = access_token.refresh! if access_token.expired?
      super 
    end
    #rescue ::OAuth2::Error, CallbackError => e
     # fail!(:invalid_credentials, e)
    #rescue ::MultiJson::DecodeError => e
     # fail!(:invalid_response, e)
    #rescue ::Timeout::Error, ::Errno::ETIMEDOUT => e
     # fail!(:timeout, e)
    #rescue ::SocketError => e
     # fail!(:failed_to_connect, e)
  end
end
