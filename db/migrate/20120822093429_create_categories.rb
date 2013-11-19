# -*- encoding : utf-8 -*-
class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :permalink
      t.text :description
      t.integer :parent_id

    end

  end
end
