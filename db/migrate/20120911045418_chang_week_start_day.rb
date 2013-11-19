# -*- encoding : utf-8 -*-
class ChangWeekStartDay < ActiveRecord::Migration
  def up
    ScheduleItem.all.each do |item|
      item.update_attribute :effective_day_cd, (item.effective_day_cd - 1) % 6
      item.update_attribute :discontinue_day_cd, (item.discontinue_day_cd - 1) % 6
    end
  end

  def down
    ScheduleItem.all.each do |item|
      item.update_attribute :effective_day_cd, (item.effective_day_cd + 1) % 6
      item.update_attribute :discontinue_day_cd, (item.discontinue_day_cd + 1) % 6
    end
  end
end
