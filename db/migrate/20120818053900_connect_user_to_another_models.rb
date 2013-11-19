# -*- encoding : utf-8 -*-
class ConnectUserToAnotherModels < ActiveRecord::Migration
  def change
    add_column :stores, :user_id, :integer
  end
end
