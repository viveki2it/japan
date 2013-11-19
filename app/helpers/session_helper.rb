# -*- encoding : utf-8 -*-
module SessionHelper
  # Those are the two types of user : pro and user.
  # Those types match the related urls, just for convenience.
  USER_TYPES = {
    :pro => "store_owner",
    :usr => "user"
  }

  # This helper will store some methods to help customizing the session
  # according to the type of user that is currently browsing the app

  def user_is_customer?
    (user_signed_in? && current_user.is_customer?)
  end

  # Check if current_user is a store owner or not
  def user_is_store_owner?
    (user_signed_in? && current_user.is_store_owner?)
  end

  def user_wishes_it?(product = @product)
    user_is_customer? and current_user.wishlist and current_user.wishlist.products.exists?(product)
  end

  # Check if current user is a pro or not
  # This will use the method above +
  # the session variable created in application_controller#set_user_type before_filter
  def user_is_pro?
    @user_is_pro ||= (user_is_store_owner? || pro_page?)
  end

  # Does the same as user_is_pro? but without checking the signed_in user
  def pro_page?
    (session[:user_type] && session[:user_type] == USER_TYPES[:pro])
  end

  # This method is used in some place to just get back
  # the right url/path/css/javascript or whatever
  def application_type
    user_is_pro? ? "store" : "user"
  end

  # Get the temporary board if it was created
  def get_temporary_boards
    return @boards unless @boards.blank?
    @boards = ((session["temporary_board_id"].blank?) ? nil : Board.where( :id => session["temporary_board_id"].to_i))
  end
  
  def publicly_visible?(record)
    if user_is_customer? 
      if record.is_admin_valid?
        return true
      else
        return false
      end
    else
      return true
    end
  end

end
