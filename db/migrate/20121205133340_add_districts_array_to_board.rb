# -*- encoding : utf-8 -*-
class AddDistrictsArrayToBoard < ActiveRecord::Migration
  def change
    remove_column :boards, :district
    add_column :boards, :districts_serialized, :string
  end
end
