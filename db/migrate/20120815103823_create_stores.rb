# -*- encoding : utf-8 -*-
class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :phone
      t.text :description
      t.attachment :logo
      t.integer :address_id
      t.integer :week_schedule_id
      t.integer :category_id
      t.timestamps
    end
  end
end
