class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation,:facebook_uid, :password_salt, :crypted_password, :persistence_token,:access_token,:fb_profile_pic,:oauth_token,:oauth_token_secret, :relationship_status
  has_many :feeds, :dependent => :destroy
  acts_as_authentic do |c|
    c.validate_email_field = false
    c.validate_password_field = false
  end

  def self.find_or_create_from_oauth(auth_hash)
    provider = auth_hash["provider"]
    uid = auth_hash["uid"]
    case provider
      when 'facebook'
        if user = self.find_by_email(auth_hash["info"]["email"])
          user.update_user_from_facebook(auth_hash)
          return user
        elsif user = self.find_by_facebook_uid(uid)
          return user
        else
          return self.create_user_from_facebook(auth_hash)
        end
    end
  end

  def self.create_user_from_facebook(auth_hash)
    self.create({
                    :facebook_uid => auth_hash["uid"],
                    :access_token => auth_hash['credentials']['token'],
                    :first_name => auth_hash["info"]["first_name"] + " " + auth_hash["info"]["last_name"],
                    :email => auth_hash["info"]["email"],
                    :crypted_password => "facebook",
                    :password_salt => "facebook",
                    :persistence_token => "facebook",
                    :fb_profile_pic => auth_hash.info.image,
                    :relationship_status => auth_hash['extra']['raw_info']['relationship_status']
                })
  end

  def update_user_from_facebook(auth_hash)
    self.update_attributes({
                               :facebook_uid => auth_hash["uid"]
                           })
  end

  def clear_feeds
    self.feeds.each{|f| f.destroy}
  end

end
