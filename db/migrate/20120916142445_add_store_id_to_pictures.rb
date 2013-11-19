# -*- encoding : utf-8 -*-
class AddStoreIdToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :store_id, :integer
  end
end
