# -*- encoding : utf-8 -*-
class ChangeDealsColumnsTypes < ActiveRecord::Migration
  def up
    change_column :deals, :normal_price,   :decimal
    change_column :deals, :discount_price, :decimal
  end

  def down
    change_column :deals, :normal_price,   :integer
    change_column :deals, :discount_price, :integer
  end
end
