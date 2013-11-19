# -*- encoding : utf-8 -*-


class User < ActiveRecord::Base
  as_enum :role, %w(guest user store_owner admin)

  # Associations
  has_one :store, inverse_of: :user

  has_one :wishlist

  has_many :options
  has_many :boards

  # Related to followed stores
  has_and_belongs_to_many :followed_stores, class_name: Store, join_table: :user_follows
  has_many :news, through: :followed_stores
  has_many :deals, through: :followed_stores
  has_many :products, through: :followed_stores
  has_many :connections, :dependent => :destroy


  # Devise

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Unprotected attributes

  attr_accessible :email, :password, :password_confirmation, :remember_me, :store, :role,
    :followed_stores, :followed_store_ids, :store_attributes, :current_password,
    :wizard_step, :options_attributes, :uid, :provider, :token, :token_expires_in, :secret_token,
    :first_name, :last_name

  # Nested attributes
  accepts_nested_attributes_for :store
  accepts_nested_attributes_for :options

  after_create :send_welcom_mail

  validates :first_name, :last_name, :presence => true, :if => :hasRoleUser?
  
  # Callbacks
  before_destroy :purge_associations

  # instance functions

  def has_reached_boards_limit?
    return true if self.boards.size >= Board::BOARDS_LIMIT
    return false
  end

  def hasRoleUser?
    return :role == 'user'
  end
  
  def is_store_owner?
    self.role == "store_owner"
  end
  
  # TODO: replace hasRoleUser? with this function
  # and all the role equalities
  def is_customer?
    self.role == "user"
  end

  def fullname
    self.first_name.titleize + " " + self.last_name.titleize
  end

  def option
    @option = {}
    options.each do |option|
      @option[option.key] = option.value
    end
    return @option
  end

  # Functions related to facebook authentication
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    return user
  end

  def self.create_for_facebook_oauth(auth, role)
    user = User.create(
      :role       => role.to_s,
      :provider   => auth.provider,
      :uid        => auth.uid,
      :email      => auth.info.email,
      :first_name => auth.info.first_name,
      :last_name  => auth.info.last_name,
      :password   => Devise.friendly_token[0, 20],
      :token     => auth.credentials.token,
      :token_expires_in => Time.at(auth.credentials.expires_at)
    )
  end

  def connect_for_facebook_oauth(auth)
    @provider = auth.provider
    @uid = auth.uid
    @token = auth.credentials.token
    @token_expires_in = auth.credentials.expires_at
    @save
  end

  def update_for_facebook_oauth(auth)
    self.update_attributes({
        :token => auth.credentials.token,
        :token_expires_in => Time.at(auth.credentials.expires_at)
      })
  end
  
  
  #def facebook_publish_welcome_message_to_wall
  #  @graph = Koala::Facebook::API.new(facebook_token)
  #  @graph.put_wall_post("[test debug facebook connect]")
  #end
  
  private
    
    def send_welcom_mail
      UsersMailer::welcome(self)
    end
    
    def purge_associations
      logger.info "Cleaning associations"
      self.followed_stores.clear
    end
  
end

# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  email                     :string(255)      default(""), not null
#  encrypted_password        :string(255)      default(""), not null
#  reset_password_token      :string(255)
#  reset_password_sent_at    :datetime
#  remember_created_at       :datetime
#  sign_in_count             :integer          default(0)
#  current_sign_in_at        :datetime
#  last_sign_in_at           :datetime
#  current_sign_in_ip        :string(255)
#  last_sign_in_ip           :string(255)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  role_cd                   :integer          default(0)
#  confirmation_token        :string(255)
#  confirmed_at              :datetime
#  confirmation_sent_at      :datetime
#  unconfirmed_email         :string(255)
#  provider                  :string(255)
#  uid                       :string(255)
#  facebook_token            :string(255)
#  facebook_token_expires_in :datetime
#  first_name                :string(255)
#  last_name                 :string(255)
#

