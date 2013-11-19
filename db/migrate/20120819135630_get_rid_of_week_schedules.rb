# -*- encoding : utf-8 -*-
class GetRidOfWeekSchedules < ActiveRecord::Migration
  def change
    drop_table :week_schedules
    add_column :day_schedules, :store_id, :integer
  end
end
