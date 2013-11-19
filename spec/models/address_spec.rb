# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: addresses
#
#  id            :integer          not null, primary key
#  street_number :string(255)
#  street_name   :string(255)
#  postal_code   :string(255)
#  city          :string(255)      default("Paris")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  store_id      :integer
#  district      :integer
#  latitude      :float
#  longitude     :float
#  gmaps         :boolean
#

require 'spec_helper'

describe Address, pending: true do
  it "should have valid factory" do
    build(:address).should be_valid
  end

  it { should validate_presence_of(:street_number) }
  it { should validate_presence_of(:street_name) }
  it { should validate_presence_of(:postal_code) }
  it { should validate_numericality_of(:postal_code) }
  it { should validate_presence_of(:city) }
  it { should belong_to(:store) }

  describe ":to_s method" do
    before do
      @address = build(:address)
    end
    subject { @address.to_s }
    it { should == "#{@address.street_number} #{@address.street_name}, #{@address.postal_code} #{@address.city}" }
  end

  describe "validation for" do
    before :each do
      @address = build(:address)
    end
    after :each do
      @address.should_not be_valid
    end
    describe "postal_code" do
      it "should not accept blank value" do
        @address.postal_code = ''
      end
      it "should not accept nil" do
        @address.postal_code = nil
      end
      it "should not accept short codes" do
        @address.postal_code = '720'
      end
      it "should not accept long codes" do
        @address.postal_code = '753420'
      end
      it "should not accept non-numerical values" do
        @address.postal_code = '75A20'
      end
      it "should not accept float point values" do
        @address.postal_code = '75,20'
      end
      it "should not accept codes outside of Paris" do
        @address.postal_code = '12320'
      end
    end
    describe "district" do
      it "should not accept values more  than 20" do
        @address.postal_code = '75399'
      end
    end
  end
end
