class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :first_name
      t.string    :last_name
      t.string    :email
      t.string    :crypted_password
      t.string    :password_salt
      t.string    :persistence_token
      t.string    :perishable_token
      t.string    :facebook_uid
      t.string    :access_token
      t.string    :fb_profile_pic
      t.string    :oauth_token
      t.string    :oauth_token_secret
      t.string    :relationship_status
      t.timestamps
    end
  end
end
