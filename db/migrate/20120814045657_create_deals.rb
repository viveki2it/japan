# -*- encoding : utf-8 -*-
class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :name
      t.text :description
      t.integer :slots
      t.integer :normal_price
      t.integer :discount_price
      t.date :starts_at
      t.date :ends_at

      t.timestamps
    end
  end
end
