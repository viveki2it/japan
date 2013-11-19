# -*- encoding : utf-8 -*-
class ConnectStoreToNewsAndDealsAndProducts < ActiveRecord::Migration
  def change
    add_column :deals, :store_id, :integer
    add_column :news, :store_id, :integer
    add_column :products, :store_id, :integer
  end
end
