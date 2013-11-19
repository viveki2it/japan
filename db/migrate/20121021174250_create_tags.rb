# -*- encoding : utf-8 -*-
class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :group_id
      t.integer :category_id
    end
  end
end
