# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: options
#
#  id      :integer          not null, primary key
#  user_id :integer          not null
#  key     :string(255)      not null
#  value   :boolean          default(FALSE)
#

class Option < ActiveRecord::Base
  attr_accessible :key, :user_id, :value
  belongs_to :user
end
