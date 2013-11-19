# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: tags_groups
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class TagsGroup < ActiveRecord::Base
  attr_accessible :name
  has_many :tags, :foreign_key => :group_id, inverse_of: :group
end
