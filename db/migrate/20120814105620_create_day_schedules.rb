# -*- encoding : utf-8 -*-
class CreateDaySchedules < ActiveRecord::Migration
  def change
    create_table :day_schedules do |t|
      t.integer :day_cd
      t.time :start_at
      t.time :end_at

      t.timestamps
    end
  end
end
