# -*- encoding : utf-8 -*-
require 'spec_helper'

describe User do
  it "should have valid factory" do
    build(:user).should be_valid
  end
  describe ":role attribute" do
    before :each do
      @user = create :user
    end
    it "should accept guest, user, store_owner and admin as values" do
      %w(guest user store_owner admin).each do |value|
        @user.role = value
        @user.role.should == value
      end
    end
    it "should raise error when invalid value passed" do
      lambda { @user.role = 'random name' }.should raise_error(ArgumentError)
    end
  end
  it { should have_one(:store) }
  it { should have_and_belong_to_many(:followed_stores) }
  it { should have_many(:news) }
  it { should have_many(:deals) }
  it { should have_many(:products) }
end

# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  email                     :string(255)      default(""), not null
#  encrypted_password        :string(255)      default(""), not null
#  reset_password_token      :string(255)
#  reset_password_sent_at    :datetime
#  remember_created_at       :datetime
#  sign_in_count             :integer          default(0)
#  current_sign_in_at        :datetime
#  last_sign_in_at           :datetime
#  current_sign_in_ip        :string(255)
#  last_sign_in_ip           :string(255)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  role_cd                   :integer          default(0)
#  confirmation_token        :string(255)
#  confirmed_at              :datetime
#  confirmation_sent_at      :datetime
#  unconfirmed_email         :string(255)
#  provider                  :string(255)
#  uid                       :string(255)
#  facebook_token            :string(255)
#  facebook_token_expires_in :datetime
#  first_name                :string(255)
#  last_name                 :string(255)
#

