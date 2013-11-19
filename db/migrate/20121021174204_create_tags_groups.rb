# -*- encoding : utf-8 -*-
class CreateTagsGroups < ActiveRecord::Migration
  def change
    create_table :tags_groups do |t|
      t.string :name
    end
  end
end
