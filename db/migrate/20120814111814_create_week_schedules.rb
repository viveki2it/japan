# -*- encoding : utf-8 -*-
class CreateWeekSchedules < ActiveRecord::Migration
  def change
    create_table :week_schedules do |t|
      t.timestamps
    end

    add_column :day_schedules, :week_schedule_id, :integer
  end
end
