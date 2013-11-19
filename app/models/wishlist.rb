# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: wishlists
#
#  id      :integer          not null, primary key
#  user_id :integer          not null
#

class Wishlist < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :products,:uniq => false
  has_and_belongs_to_many :deals
  
  before_destroy :purge_associations
  
  private
  
    def purge_associations
      logger.info "Cleaning associations"
      self.products.clear
      self.deals.clear
    end
end
