# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Store do
  it "should have valid factory" do
    build(:store).should be_valid
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:logo_file_name) }
  it { should have_one(:address) }
  it { should have_many(:pictures) }
  it { should have_many(:deals) }
  it { should have_many(:news) }
  it { should have_many(:products) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }
  it { should_not validate_presence_of(:address) }
  it { should belong_to(:category) }
  it { should have_and_belong_to_many(:following_users) }
  it { should have_many(:schedule_items) }
  it { should have_many(:library_pictures) }
end

# == Schema Information
#
# Table name: stores
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  phone             :string(255)
#  description       :text
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#  wizard_step       :integer          default(1)
#  admin_validation  :boolean          default(FALSE)
#  website_url       :string(255)
#  facebook_url      :string(255)
#

