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

require 'spec_helper'

describe Category do
  subject { build :category }
  it { should be_valid }
  it { should_not belong_to(:user) }
  it { should have_many(:stores) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  it { should have_many(:products) }
  it { should have_many(:deals) }
  it { should have_many(:news) }
  it { should belong_to(:parent) }
  it { should have_many(:children) }
end
