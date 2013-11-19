# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Deal do
  let(:deal) { build :deal }
  subject { deal }

  it "should have valid factory" do
    build(:deal).should be_valid
  end

  # Basic validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:slots) }
  it { should validate_numericality_of(:slots) }
  it { should validate_presence_of(:discount) }
  it { should validate_numericality_of(:discount) }
  it { should validate_presence_of(:starts_at) }
  it { should validate_presence_of(:ends_at) }
  it { should have_one(:picture) }
  it { should accept_nested_attributes_for(:picture) }
  it { should belong_to(:store) }
  it { should validate_presence_of(:store) }
  it { should_not accept_nested_attributes_for(:pictures) }

  it "should validate that 0 < discount < 100" do
    build(:deal, discount: 150).should_not be_valid
    build(:deal, discount: 0).should_not be_valid
  end

  it { should_not have_many(:categories) }
end

# == Schema Information
#
# Table name: deals
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  description      :text
#  slots            :integer
#  normal_price     :decimal(9, 2)
#  discount_price   :decimal(9, 2)
#  starts_at        :date
#  ends_at          :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  store_id         :integer
#  tag_id           :integer
#  admin_validation :boolean          default(FALSE)
#

