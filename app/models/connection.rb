class Connection < ActiveRecord::Base
  attr_accessible :uid, :provider, :token, :secret, :user_id, :name, :token_type, :blog_id, :blog_url, :scope, :blogger_user_id, :blogger_user_name, :blogger_user_password
  belongs_to :user

  # Functions related to twitter or tumblr or wordpress authentication
  def self.find_for_oauth(auth, user)
    user_connect = Connection.where(:user_id => user.id, :provider => auth.provider, :uid => auth.uid).first
    return user_connect
  end

  def self.create_for_oauth(auth, user)
    user_connect = Connection.new(
      :provider   => auth.provider,
      :uid        => auth.uid,
      :name => (auth.provider == "facebook" ? auth.info.first_name : auth.info.name),
      :token     => auth.credentials.token,
      :secret => auth.credentials.secret,
      :user_id => user.id
    )
    user_connect.save(:validate => false)
    return user_connect
  end

  def update_for_oauth(auth)
    self.update_attributes({
        :token => auth.credentials.token,
        :secret => auth.credentials.secret
      })
  end
  
end
