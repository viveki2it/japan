# -*- encoding : utf-8 -*-
module StaticLinksHelper

  # This helper will store all the static links, which match the last catch-all route
  # So that they can be re-used wherever we want to and be all located in one place

  # Return the home page path depending of the current_user role
  def home_page_url(signed_out = false)
    if user_is_store_owner? && !signed_out
      if current_user.store
        edit_store_url(current_user.store)
      else
        stores_erased_path  
      end
    elsif pro_page?
      pro_home_url
    elsif user_signed_in? && !signed_out
      user_home_url
    # No longer needed ?
    #elsif !get_temporary_boards.blank?
    #  "/user/boards/#{get_temporary_boards.first.id}"
    else
      "/user/boards"
    end
  end

  def pricing_link
    link_to "Tarifs", '/static/rates'
  end

  def faq_link
    link_to "FAQ", '/static/faq'
  end

  def help_link
    link_to "Comment ça marche", '/static/how-it-works'
  end

  def about_link(link_text = "A propos")
    link_to link_text, '/static/about'
  end

  def terms_of_use_link
    if user_is_pro?
      link_to "Conditions générales d'utilisation - professionnels", "/static/terms-of-use-store"
    else
      link_to "Conditions générales d'utilisation - consommateurs", "/static/terms-of-use-customer"
    end

  end

  def legals_link
    link_to 'Mentions légales', "/static/legal-notice"
  end



end
