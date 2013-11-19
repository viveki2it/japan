# -*- encoding : utf-8 -*-

class Deal < ActiveRecord::Base
  include StoreEntity
  include ActionView::Helpers::DateHelper 
  include Variable # Variant/Stock management
  has_and_belongs_to_many :wishlists

  paginates_per 5 # Kaminari default


  # Unprotected attributes
  attr_accessible :description, :normal_price,:discount_price, :ends_at, :name, :starts_at, 
      :admin_validation #, :slots

  # Associations
  
  
  # Validations
  validates :name, presence: true
  validates :description, presence: true
  #validates :slots, presence: true, numericality: { only_integer: true }
  validates :normal_price, presence: true, numericality: { only_integer: false }
  validates :discount_price, presence: true, numericality: { only_integer: false, less_than: :normal_price }
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  delegate :name, to: :store, prefix: true

  # Instance methods
  def discount_rate
    rate = (1 - self.discount_price.to_f/self.normal_price.to_f) * 100
    rate.ceil
  end
  
  def remaining_days
    if self.ends_at > Date.today
      distance_of_time_in_words_to_now(self.ends_at)
    else
      "Déjà expiré"
    end
  end
  
  before_destroy :purge_associations
  
  private
  
    def purge_associations
      logger.info "Cleaning associations"
      self.wishlists.clear
    end
end

# == Schema Information
#
# Table name: deals
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  description      :text
#  slots            :integer
#  normal_price     :decimal(9, 2)
#  discount_price   :decimal(9, 2)
#  starts_at        :date
#  ends_at          :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  store_id         :integer
#  tag_id           :integer
#  admin_validation :boolean          default(FALSE)
#
