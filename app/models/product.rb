# -*- encoding : utf-8 -*-

class Product < ActiveRecord::Base
  include StoreEntity
  include Variable # Variant/Stock management
  has_and_belongs_to_many :wishlists

  paginates_per 5 # Kaminari default

  # Associations
  #belongs_to :tag

  # Unprotected attributes
  attr_accessible :description, :name, :price, :admin_validation,:social_site,:social_site1 #, :tag_id

  # Validations
  validates :description, presence: true
  validates :name, presence: true, allow_blank: false
  validates :price, presence: true, numericality: :only_integer
  #validates :tag_id, presence: true
  
  before_destroy :purge_associations
  
  private
  
    def purge_associations
      logger.info "Cleaning associations"
      self.wishlists.clear
    end
end

# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  price            :decimal(9, 2)
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  store_id         :integer
#  tag_id           :integer
#  admin_validation :boolean          default(FALSE)
#

