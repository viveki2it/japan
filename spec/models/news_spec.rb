# -*- encoding : utf-8 -*-
require 'spec_helper'

describe News do
  it "should have valid factory" do
    build(:news).should be_valid
  end
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should have_one(:picture) }
  it { should accept_nested_attributes_for(:picture) }
  it { should belong_to(:store) }
  it { should validate_presence_of(:store) }
  it { should_not accept_nested_attributes_for(:pictures)}
  it { should_not have_many(:categories) }
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

