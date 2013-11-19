class CreateProductVariants < ActiveRecord::Migration
  def change
    create_table :product_variants do |t|
      t.integer :product_id
      t.string :name, null: false, default: 'variant'
      t.integer :stock, null: false, default: 0

      t.timestamps
    end
    # Removed since it triggered a migration bug in heroku
    # add_index :product_variants, :product_id
  end
end
