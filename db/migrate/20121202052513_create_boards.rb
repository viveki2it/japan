# -*- encoding : utf-8 -*-
class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :title
      t.integer :district

      t.timestamps
    end
  end
end
