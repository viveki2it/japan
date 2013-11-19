# -*- encoding : utf-8 -*-
class GetRidOfWeekSchedules2 < ActiveRecord::Migration
  def change
    remove_column :stores, :week_schedule_id
  end
end
