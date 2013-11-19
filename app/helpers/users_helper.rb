# -*- encoding : utf-8 -*-
module UsersHelper

  # This function will check if the user is following the store
  # To do so and to prevent rails from doing too many requests to the database
  # we put the followed store ids in a variable and set it only once
  #
  def user_is_following_store?(store, check_one_store = false)
    return unless user_signed_in?
    # If we want to check only one store, we don't have to bother us
    # Just try to find it from the followed stores
    if check_one_store
      return current_user.followed_stores.include?(store)
    end

    # Else we get all the followed store ids, it's faster
    unless @followed_store_ids
      @followed_store_ids = current_user.followed_stores.pluck(:store_id)
    end

    return @followed_store_ids.include?(store.id.to_s)
  end
end
