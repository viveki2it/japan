# -*- encoding : utf-8 -*-

class Store < ActiveRecord::Base

  # Associations
  belongs_to :user, inverse_of: :store
  belongs_to :category, inverse_of: :stores

  has_one :address, inverse_of: :store

    # Classic pictures
  has_many :pictures, as: :decorated, inverse_of: :decorated, class_name: Picture

    # Products news and deals
  has_many :news, inverse_of: :store, :include => [:picture, :tag]
  has_many :deals, inverse_of: :store, :include => [:picture, :tag]
  has_many :products, inverse_of: :store, :include => [:picture, :tag]
  has_many :schedule_items, inverse_of: :store
  has_many :library_pictures, inverse_of: :store, class_name: Picture
  has_many :categories_associations, dependent: :destroy
  has_many :categories, through: :categories_associations

  # Followers
  has_and_belongs_to_many :following_users, class_name: User, join_table: :user_follows


  has_attached_file :logo, styles: {thumb: "160x160", normal: "450x450"},
                           default_url: "/assets/store/default_:style_logo.png"
  has_paper_trail only: [:categories_associations]

  # Unprotected attributes
  attr_accessible :address, :description, :logo, :name, :phone, :user_id, :admin_validation,
    :website_url, :facebook_url, :wizard_step,   
    :address_attributes, :deal_ids, :news_ids, :product_ids, :deals, :news,
    :picture_ids, :pictures_attributes, :produsubscriber_idcts, :following_users, :following_user_ids,
    :schedule_items_attributes, :categories_associations, :categories_associations_attributes

  # Validations
  validates_presence_of :name, :user
  validate :check_categories,  :if => Proc.new { |store| store.wizard_step > 1 or store.wizard_step == 0}
  validates_associated :address, :if => Proc.new { |store| store.wizard_step > 2 or store.wizard_step == 0}
  validates_associated :categories_associations
  validates :phone, :on => :update, presence: true, :format => {:with => /\A[0-9 .()+-]+\z/},
                    :if => Proc.new { |store| (store.wizard_step > 2 or store.wizard_step == 0)}
  validates_presence_of :description, :on => :update,
                                      :if => Proc.new { |store| store.wizard_step > 4 or store.wizard_step == 0}

  # Delegations
  delegate :to_s, to: :address, prefix: true
  delegate :district, to: :address
  delegate :count, to: :following_users, prefix: true

  # nested attributes
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :schedule_items
  accepts_nested_attributes_for :pictures
  accepts_nested_attributes_for :categories_associations, allow_destroy: true

  ## Callbacks
  before_destroy :purge_associations

  ## Class functions
  #
  def self.logo_from_base64(params)
    data = params[:image_base64].split(',')[1]
    io = StringIOProxy.new(Base64.decode64 data)
    io.content_type = params[:image_type]
    io.original_filename = params[:image_filename]
    io
  end

  # Get the store, including common associated records
  # I know I could use a default scope, but... I don't know if those
  # includes are needed all the time
  # (Lta: good question. I think this is the case for picture, but not for taag)
  def self.default_find(store_id)
    self.includes(:news, :products => :tag).find(store_id.to_i)
  end
  
  ## Instance functions
  #
  def is_admin_valid?
    return admin_validation
  end

  def parent_category
    categories.first.parent if categories.first
  end

  def default_schedule!
    schedule_items.destroy_all
    ScheduleItem.ABBREVIATED_WEEKDAYS.each do |day|
      schedule_items.create(day: day, start_at: "2000-01-01T08:00:00Z", end_at: "2000-01-01T20:00:00Z",
                            status: :open)
    end
  end
  
  private
  
    def check_categories
      errors.add :base, :provide_at_least_one_subcategory unless categories.any?
    end

    def purge_associations
      logger.info "Cleaning associations"
      self.following_users.clear
    end

end

# == Schema Information
#
# Table name: stores
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  phone             :string(255)
#  description       :text
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#  wizard_step       :integer          default(1)
#  admin_validation  :boolean          default(FALSE)
#  website_url       :string(255)
#  facebook_url      :string(255)
#

