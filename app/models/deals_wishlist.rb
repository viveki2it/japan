# -*- encoding : utf-8 -*-
class DealsWishlist < ActiveRecord::Base
  belongs_to :deal
  belongs_to :wishlist
end