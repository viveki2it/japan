# -*- encoding : utf-8 -*-
class AddWishlist < ActiveRecord::Migration
  def up
    create_table :wishlists do |t|
      t.references :user,null:false
    end

    create_table :deals_wishlists,:id => false do |t|
      t.references :wishlist,null:false
      t.references :deal,null:false
    end
    add_index :deals_wishlists, ["wishlist_id", "deal_id"], :unique => true

    create_table :products_wishlists,:id => false do |t|
      t.references :wishlist,null:false
      t.references :product,null:false
    end
    add_index :products_wishlists, ["product_id", "wishlist_id"], :unique => true
  end

  def down
    drop_table :wishlists
    drop_table :deals_wishlists
    drop_table :products_wishlists
  end
end
