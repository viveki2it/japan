# -*- encoding : utf-8 -*-
class AddressDistrictPersistance < ActiveRecord::Migration
  def change
    change_column :addresses, :postal_code, :string, length: 5
    add_column :addresses, :district, :integer
  end
end
