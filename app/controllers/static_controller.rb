# -*- encoding : utf-8 -*-
# This controller renders view that corresponds to permalink passed as URL parameter

class StaticController < ApplicationController
  VIEW_PREFIX = "static"

  def show

    permalink = params[:permalink] || 'index'

    # Special redirection if the user tries to create a new board and has reached the limit
    if request.fullpath.include?("boards/new") && user_signed_in? && current_user.has_reached_boards_limit?
      redirect_to home_page_url
    elsif template_exists? permalink, VIEW_PREFIX
      render "#{VIEW_PREFIX}/#{permalink}"#,:layout => params[:layout]
    else
      raise StaticPageMissing, "Static page '#{permalink}' not found"
    end
  end


end
