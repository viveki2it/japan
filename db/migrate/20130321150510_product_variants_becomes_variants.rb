class ProductVariantsBecomesVariants < ActiveRecord::Migration
  def change
    rename_table :product_variants, :variants
    change_table :variants do |t|
      t.rename :product_id, :variable_id
      t.string :variable_type, null: false, default: "Product"
    end
  end
end
