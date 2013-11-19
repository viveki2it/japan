# -*- encoding : utf-8 -*-

class Board < ActiveRecord::Base
  # Constants
  BOARDS_LIMIT = 3

  # Unprotected attributes
  attr_accessible :category_ids, :tag_ids, :district_ids, :title, :user_id
  attr_accessor   :page

  #  Associations
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :tags
  belongs_to :user, inverse_of: :boards

  has_many :stores, through: :categories
  has_many :products, through: :tags
  has_many :deals, through: :tags
  has_many :news, through: :stores

  # Validations
  validates_presence_of :title #, :user_id

  # Callbacks
  before_validation do
    self.districts_serialized = district_ids.join ','
  end

  before_create :check_boards_number
  before_destroy :purge_associations 

  ##
  # Public functions

    ## Class Methods

    # It's better to have this kind of function in the model
    # It will be easier to modify in the future and it's more DRY.
  def self.find_user_board(board_id)
    self.includes(
      :deals => [:picture],
      :news => [:picture],
      :products => [:picture]).find(board_id.to_i)
  end

    ## Instance methods
  def district_ids
    @district_ids ||= districts_serialized.split(',').map { |s| s.to_i }
  end

  def district_ids=(array)
    @district_ids = array.to_a
  end

    # Get paginated datas for infinite scroll
  def paginated_products
    p = self.products.where(:admin_validation => true)
    unless self.page.blank?
      p.page(self.page)
    end
  end

  def paginated_news
    n = self.news.where(:admin_validation => true)
    unless self.page.blank?
      n.page(self.page)
    end
  end

  def paginated_deals
    d = self.deals.where(:admin_validation => true)
    unless self.page.blank?
      d.page(self.page)
    end
  end

  private

    # Callbacks functions
    def check_boards_number
      # Just return if the user is nil and continue the creation
      return true if self.user.nil?

      if self.user.has_reached_boards_limit?
        # If the user has already 3 boards, skip the creation and add an error
        self.errors.add(:user, "Vous avez atteint le nombre maximum de boards (#{BOARDS_LIMIT})")
        return false
      else
        return true
      end
    end
    
    def purge_associations
      logger.info "Cleaning associations"
      self.tags.clear
      self.categories.clear
    end
end

# == Schema Information
#
# Table name: boards
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  title                :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  districts_serialized :string(255)
#

