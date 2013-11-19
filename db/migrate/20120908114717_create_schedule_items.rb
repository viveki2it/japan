# -*- encoding : utf-8 -*-
class CreateScheduleItems < ActiveRecord::Migration
  def change
    create_table :schedule_items do |t|
      t.integer :effective_day_cd
      t.integer :discontinue_day_cd
      t.time :start_at
      t.time :end_at
      t.integer :store_id

      t.timestamps
    end
  end
end
