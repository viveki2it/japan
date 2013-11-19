# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  permalink   :string(255)
#  description :text
#  parent_id   :integer
#

class Category < ActiveRecord::Base
  has_many :products, through: :stores, inverse_of: :categories
  has_many :news, through: :stores, inverse_of: :categories
  has_many :deals, through: :stores, inverse_of: :categories
  has_and_belongs_to_many :boards
  has_many :categories_associations, dependent: :destroy
  has_many :stores, through: :categories_associations
  belongs_to :parent, class_name: CategoriesParent, foreign_key: :parent_id

  attr_accessible :description, :permalink, :title, :stores, :store_ids, :parent_id, :parent, :child_ids,
                  :children, :product_ids, :news_ids, :deal_ids

  validates_presence_of :title, :description
  validates :permalink, presence: true, uniqueness: true

  before_validation :generate_permalink, if: "permalink.nil? || permalink.empty?"
  before_destroy :purge_associations
  

  private

    def generate_permalink
      self.permalink = title.parameterize '_'
    end

    def purge_associations
      logger.info "Cleaning associations"
      self.boards.clear
    end

end
