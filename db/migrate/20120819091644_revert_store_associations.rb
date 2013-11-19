# -*- encoding : utf-8 -*-
class RevertStoreAssociations < ActiveRecord::Migration
  def change
    add_column :addresses, :store_id, :integer
    add_column :week_schedules, :store_id, :integer
    
  end
end
