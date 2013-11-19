# -*- encoding : utf-8 -*-
class AddTagsToProduct < ActiveRecord::Migration
  def up
    add_column :products, :tag_id, :integer
  end

  def down
    remove_column :products, :tag_id
  end
end
