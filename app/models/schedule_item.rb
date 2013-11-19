# -*- encoding : utf-8 -*-
class ScheduleItem < ActiveRecord::Base
  def self.ABBREVIATED_WEEKDAYS
    [:mon, :tue, :wed, :thu, :fri, :sat, :sun]
  end

  attr_accessible :store_id, :day, :status_cd, :status
  attr_accessible :pause_start_at, :pause_end_at, :start_at, :end_at

  # Associations
  belongs_to :store, inverse_of: :schedule_items

  # Enums
  as_enum :day, self.ABBREVIATED_WEEKDAYS, prefix: true
  as_enum :status, close: 0, open: 1

  # Validation
  validates_presence_of :day_cd, :status_cd, :end_at, :start_at, :store_id
  validate :start_before_end

  private

  def start_before_end
    if start_at > end_at
      errors.add :base, :start_before_end
    end
    if pause_start_at and pause_end_at and pause_start_at > pause_end_at
      errors.add :base, :pause_start_before_end
    end
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

