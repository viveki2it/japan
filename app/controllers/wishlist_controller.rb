# -*- encoding : utf-8 -*-
class WishlistController < ApplicationController
  layout 'user-static-jangalist'

  def index
    unless current_user.wishlist
      current_user.build_wishlist
      current_user.wishlist.save
    end
    @jangalist = current_user.wishlist
    # get stores from products and deals
    store_ids = @jangalist.products.pluck(:store_id)
    store_ids += @jangalist.deals.pluck(:store_id)
    store_ids = store_ids.uniq
    @stores = Store.find(store_ids)
  end
end
