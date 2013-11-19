class StoreMultipleCategories < ActiveRecord::Migration
  def up
    create_table :categories_associations do |t|
      t.integer :store_id, null: false
      t.integer :category_id, null: false
    end
    add_index :categories_associations, :store_id
    add_index :categories_associations, :category_id

    Store.all.each do |store|
      if store.category_id && Category.exists?(store.category_id)
        cat = Category.find(store.category_id)
      end 
      if cat
        store.categories << cat
        store.save
      end
    end

    remove_column :stores, :category_id
  end

  def down
    add_column :stores, :category_id, :integer

    Store.all.each do |store|
      if store.categories.first
        store.category_id = store.categories.first.id
        store.save
      end
    end

    drop_table :categories_associations
  end
end
