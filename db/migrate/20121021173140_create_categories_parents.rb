# -*- encoding : utf-8 -*-
class CreateCategoriesParents < ActiveRecord::Migration
  def change
    create_table :categories_parents do |t|
      t.string :title
      t.string :permalink

    end
  end
end
