# -*- encoding : utf-8 -*-
class AllowMultipleCategoriesForBoard < ActiveRecord::Migration
  def change
    remove_column :boards, :category_id
    create_table :boards_categories, id: false do |t|
      t.integer :board_id
      t.integer :category_id
    end

    add_index :boards_categories, :board_id
  end
end
