# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: tags
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  group_id    :integer
#  category_id :integer
#

class Tag < ActiveRecord::Base
  attr_accessible :name, :group, :group_id, :category, :category_id
  has_and_belongs_to_many :boards
  belongs_to :group, class_name: TagsGroup, inverse_of: :tags
  belongs_to :category
  has_many :products
  has_many :news
  has_many :deals
  
  # Callbacks
  before_destroy :purge_associations
  
  
  private
  
    def purge_associations
      logger.info "Cleaning associations"
      self.boards.clear
    end
end
