# -*- encoding : utf-8 -*-
class RemoveGoogleMaps < ActiveRecord::Migration
  def change
    remove_column :stores, :latitude, :longitude, :gmaps
  end
end
