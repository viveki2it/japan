# -*- encoding : utf-8 -*-
class AddLastNameColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
  end
end
