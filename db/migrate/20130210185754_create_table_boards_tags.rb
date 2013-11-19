# -*- encoding : utf-8 -*-
class CreateTableBoardsTags < ActiveRecord::Migration
  def change
    create_table :boards_tags, id: false do |t|
      t.integer :board_id
      t.integer :tag_id
    end

    add_index :boards_tags, :board_id
  end
end
