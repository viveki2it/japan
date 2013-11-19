# -*- encoding : utf-8 -*-
class AddFirstNameColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
  end
end
