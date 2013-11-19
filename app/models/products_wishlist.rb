# -*- encoding : utf-8 -*-
class ProductsWishlist < ActiveRecord::Base
  belongs_to :product
  belongs_to :wishlist
end