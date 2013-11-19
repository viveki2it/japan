##
## categories_associations.rb
## Login : <lta@still>
## Started on  Tue Mar 19 01:35:03 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##

class CategoriesAssociation < ActiveRecord::Base
  has_paper_trail

  belongs_to :store
  belongs_to :category

  attr_accessible :store_id, :category_id

  validates :store_id, presence: true
  validates :category_id, presence: true
end

# == Schema Information
#
# Table name: categories_associations
#
#  id          :integer          not null, primary key
#  store_id    :integer          not null
#  category_id :integer          not null
#

