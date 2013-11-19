# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  decorated_type     :string(255)
#  decorated_id       :integer
#  store_id           :integer
#

class Picture < ActiveRecord::Base
  belongs_to :decorated, polymorphic: true
  belongs_to :store, inverse_of: :library_pictures

  has_attached_file :image, styles: {:micro => "55x55#", :thumb => "90x65#",
    :mail => "157x157#", :middle => "360", :lightbox => "1024"}#,
  #:default_url => '/assets/image_example_:style.jpg'
  attr_accessible :image, :decorated_id, :decorated_type, :decorated, :store_id

  validates_presence_of :image_file_name, :store

  after_save :posting, :on => :create

  def self.prepare_params(params)
    result = {}
    if params[:image_base64]
      data = params[:image_base64].split(',')[1]
      io = StringIOProxy.new(Base64.decode64 data)
      io.content_type = params[:image_type]
      io.original_filename = params[:image_filename]
      result[:image] = io
    end

    if params[:picture]
      result.merge! params[:picture]
    else
      # TODO comprendre pourquoi les autres requetes ajax arrivent a
      # bien former les params et n'ont pas besoin de ce fix
      Picture.accessible_attributes.each do |attr|
        result[attr] = params[attr] if params[attr]
      end
    end

    result
  end

  # This method for post news or products or deals to store owner connections.
  def posting
    unless self.decorated.nil?
      if Connection.exists?(:provider => "facebook", :user_id => self.decorated.store.user.id)
        facebook_connection = Connection.where(:provider => "facebook", :user_id => self.decorated.store.user.id).first
        me = FbGraph::User.me(facebook_connection.token)
        me.feed!(
          :message => self.decorated_type == "News" ? self.decorated.title : self.decorated.name,
          :picture => self.decorated.image_url(:middle),
          :link => BASE_URL,
          :name => self.decorated_type == "News" ? self.decorated.title : self.decorated.name,
          :description => self.decorated_type == "News" ? self.decorated.content : self.decorated.description
        )
      end
      if Connection.exists?(:provider => "twitter", :user_id => self.decorated.store.user.id)
        twitter_connection = Connection.where(:provider => "twitter", :user_id => self.decorated.store.user.id).first
        me =  TwitterOAuth::Client.new(
          :consumer_key => TWITTER_CONSUMER_KEY,
          :consumer_secret => TWITTER_CONSUMER_SECRET,
          :token => twitter_connection.token,
          :secret => twitter_connection.secret
        )
        me.update("@#{twitter_connection.name} #{self.decorated_type == "News" ? self.decorated.title : self.decorated.name}, #{BASE_URL}")
      end
      if Connection.exists?(:provider => "tumblr", :user_id => self.decorated.store.user.id)
        unless self.decorated_type != "News"
          tumblr_connection = Connection.where(:provider => "tumblr", :user_id => self.decorated.store.user.id).first
          TumblrWrapper.consumer_key = TUMBLR_OAUTH_KEY
          TumblrWrapper.consumer_secret = TUMBLR_OAUTH_SECRET
          client = TumblrWrapper::Client.new
          access_token = client.build_access_token(tumblr_connection.token.to_s, tumblr_connection.secret.to_s)
          blog_resource = TumblrWrapper::BlogResource.new("#{tumblr_connection.uid}.tumblr.com", access_token)
          blog_resource.post.create({ type: 'text', title: self.decorated.title, body: self.decorated.content })
          blog_resource.post.create({ type: 'photo', source: self.decorated.image_url(:middle), link: "#{BASE_URL}" })
        end
      end
      if Connection.exists?(:provider => "wordpress", :user_id => self.decorated.store.user.id)
        unless self.decorated_type != "News"
          wordpress_connection = Connection.where(:provider => "wordpress", :user_id => self.decorated.store.user.id).first
          wordpress_auth = [wordpress_connection.uid.to_s, wordpress_connection.secret.to_s, {:access_token=>wordpress_connection.token.to_s, :param_name=>"access_token", "token_type"=>wordpress_connection.token_type.to_s, "blog_id"=>wordpress_connection.blog_id.to_s, "blog_url"=>wordpress_connection.blog_url.to_s, "scope"=>wordpress_connection.scope.to_s}]
          wpc = WordpressCom.deserialize(wordpress_auth)
          wpc.post('posts/new', :body => {
              :title => self.decorated.title,
              :content => self.decorated.content})
        end
      end
      if Connection.exists?(:provider => "blogger", :user_id => self.decorated.store.user.id)
        unless self.decorated_type != "News"
          #          account = Blogger::Account.new(user_id,"username","password")
          blogger_connection = Connection.where(:provider => "blogger", :user_id => self.decorated.store.user.id).first
          blogger_user_id = blogger_connection.blogger_user_id.to_s
          blogger_user_name = blogger_connection.blogger_user_name.to_s
          blogger_password = blogger_connection.blogger_user_password.to_s
          account = Blogger::Account.new(blogger_user_id,blogger_user_name,blogger_password)
          new_post = Blogger::Post.new(:title => self.decorated.title,
            :content => self.decorated.content)
          account.blogs.first.post(new_post)
        end
      end
    end
  end

end
