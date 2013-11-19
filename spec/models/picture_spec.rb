# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  decorated_type     :string(255)
#  decorated_id       :integer
#  store_id           :integer
#

require 'spec_helper'

describe Picture do
  it "should have valid factory" do
    build(:picture).should be_valid
  end

  it { should validate_presence_of(:image_file_name) }
  it { should belong_to(:decorated) }
  it { should_not validate_presence_of(:decorated) }
  it { should belong_to(:store) }
  it { should validate_presence_of(:store) }
end
