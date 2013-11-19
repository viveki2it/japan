# -*- encoding : utf-8 -*-
class ChangePricesScale < ActiveRecord::Migration
  def up
    change_column :products, :price,          :decimal, :precision => 9, :scale => 2
    change_column :deals,    :normal_price,   :decimal, :precision => 9, :scale => 2
    change_column :deals,    :discount_price, :decimal, :precision => 9, :scale => 2
  end

  def down
    change_column :products, :price,          :decimal
    change_column :deals,    :normal_price,   :decimal
    change_column :deals,    :discount_price, :decimal
  end
end
