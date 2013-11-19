# -*- encoding : utf-8 -*-
class StoreMap2 < ActiveRecord::Migration
  def change
	  add_column :stores, :gmaps, :boolean
  end
end
