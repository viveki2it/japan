# -*- encoding : utf-8 -*-
class RemoveDaySchedules < ActiveRecord::Migration
  def change
    drop_table :day_schedules
  end
end
