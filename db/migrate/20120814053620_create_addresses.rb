# -*- encoding : utf-8 -*-
class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_number
      t.string :street_name
      t.integer :postal_code
      t.string :city, default: "Paris"

      t.timestamps
    end
  end
end
