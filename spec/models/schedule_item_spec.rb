# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ScheduleItem do
  before do
    @schedule_item = build :schedule_item
  end

  subject { @schedule_item }

  it { should be_valid }
  it { should belong_to (:store) }
  it { should validate_presence_of(:effective_day_cd) }
  it { should validate_presence_of(:discontinue_day_cd) }
  it { should validate_presence_of(:start_at) }
  it { should validate_presence_of(:end_at) }
  it { should validate_presence_of(:store_id) }

  it "should validate that :start_at is before :end_at" do
    subject.start_at = 20.hours
    subject.end_at = 17.hours
    subject.should_not be_valid
  end

  it "should validate that :effective_day is before :discontinue_day" do
    subject.effective_day = ScheduleItem.ABBREVIATED_WEEKDAYS[1]
    subject.discontinue_day = ScheduleItem.ABBREVIATED_WEEKDAYS[0]
    subject.should_not be_valid
  end
end

# == Schema Information
#
# Table name: schedule_items
#
#  id             :integer          not null, primary key
#  start_at       :time
#  end_at         :time
#  store_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  day_cd         :integer
#  status_cd      :integer          default(1), not null
#  pause_start_at :time
#  pause_end_at   :time
#

