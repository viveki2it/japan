# -*- encoding : utf-8 -*-
class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :user_id, :null => false
      t.string :key, :null => false
      t.boolean :value, :default => false
    end
    add_index :options, ["user_id", "key"], :unique => true
  end
end
