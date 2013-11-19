# -*- encoding : utf-8 -*-
class AddTaksToItems < ActiveRecord::Migration
  def up
    add_column :news, :tag_id, :integer
    add_column :deals, :tag_id, :integer
  end

  def down
    remove_column :news, :tag_id
    remove_column :deals, :tag_id
  end
end
