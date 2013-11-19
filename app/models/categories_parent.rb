# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: categories_parents
#
#  id        :integer          not null, primary key
#  title     :string(255)
#  permalink :string(255)
#

class CategoriesParent < ActiveRecord::Base
  attr_accessible :title, :permalink
  has_many :categories,foreign_key: :parent_id
end
