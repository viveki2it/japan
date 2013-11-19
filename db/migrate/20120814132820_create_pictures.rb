# -*- encoding : utf-8 -*-
class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.attachment :image

      t.timestamps
    end
  end
end
