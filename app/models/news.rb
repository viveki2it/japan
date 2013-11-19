# -*- encoding : utf-8 -*-
class News < ActiveRecord::Base
  include StoreEntity

  paginates_per 5 # Kaminari default

  # Unprotected attributes
  attr_accessible :content, :title, :admin_validation #:tag_id

  # Validations
  validates_presence_of :content, :title
end

# == Schema Information
#
# Table name: news
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  content          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  store_id         :integer
#  tag_id           :integer
#  admin_validation :boolean          default(FALSE)
#

