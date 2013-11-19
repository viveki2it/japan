class AddAdminValidationToStoresAndStoreEntities < ActiveRecord::Migration
  def change
    add_column :products, :admin_validation, :boolean, :default => false
    add_column :news, :admin_validation, :boolean, :default => false
    add_column :deals, :admin_validation, :boolean, :default => false
    add_column :stores, :admin_validation, :boolean, :default => false
  end
end
