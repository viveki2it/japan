# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: boards
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  title                :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  districts_serialized :string(255)
#

require 'spec_helper'

describe Board do
end
