# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Product do
  it "should have a valid factory" do
    build(:product).should be_valid
  end
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:description) }
  it { should have_one(:picture) }
  it { should accept_nested_attributes_for(:picture) }
  it { should belong_to(:store) }
  it { should validate_presence_of(:store) }
  it { should_not accept_nested_attributes_for(:pictures) }
  it { should_not have_many(:categories) }
end

# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  price            :decimal(9, 2)
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  store_id         :integer
#  tag_id           :integer
#  admin_validation :boolean          default(FALSE)
#

