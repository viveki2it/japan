# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_client_context
  before_filter :set_user_type

  before_filter :redirect_to_home_page
  #before_filter :set_store_owner_mode

  include NextdoorzErrors
  include ErrorHandlingHelper
  include SessionHelper
  include StaticLinksHelper

  rescue_from StandardError, with: :rescue_error if (Rails.env!='development')
  rescue_from CanCan::AccessDenied, with: :redirect_after_access_denied

  #rescue Koala::Facebook::APIError => nil
  protected

    def set_client_context
      @gon_context = {}
      gon.categories = Category.all
      gon.form_authenticity_token = form_authenticity_token
      gon.category_parents = CategoriesParent.all
      gon.tags = Tag.all
      gon.tag_groups = TagsGroup.all
      gon.controller = params[:controller]
      # TODO: allow admin to access boards?
      if current_user and current_user.user?
        @gon_context[:boards] = current_user.boards.all
      elsif get_temporary_boards
        @gon_context[:boards] = get_temporary_boards
      end
      gon.rabl(:template => 'app/views/users/context.rabl')
    end

  def redirect_to_home_page
    return unless request.env['PATH_INFO'] == '/pro'
    if user_is_store_owner?
      redirect_to edit_store_url(current_user.store)
    end
  end

  private

    # This method is used for rendering error responses. It uses functions
    # from #ErrorHandlingHelper module to take proper actions depending on
    # error type. Best practice is to use it like this:
    #    rescue_from StandardError, with: :rescue_error
    # Please note that it works only for #StandardError. #Exception handling is not affected by this.
    #
    # === Parameters
    # <tt>error</tt> this catches the error that was raised
    def rescue_error(error)
      log_write error
      respond_to do |format|
        format.html do
          if status_for_error(error) == 404
            render "static/404"
          else
            flash[:error] = error.message
            do_redirect_for error, status: status_for_error(error)
          end
        end
        format.json do
          render_error_message error.message, status: status_for_error(error)
        end
      end
    end
    
=begin
    def set_store_owner_mode
      if user_is_store_owner?
        if controller_name == 'stores' and action_name == 'edit'
          params.delete :preview
          default_url_options.delete :preview
        end

        unless params[:preview]
          @edit_store_mode = true
        else
          default_url_options[:preview] = true
        end
      end
    end
=end
      # Set the proper layout depending on the user role (stored in the User database)
      # See the views/layouts folder to take a look at corresponding layouts
      # By default it returns the store layout
      def set_layout
        return 'store' unless user_signed_in?
        case current_user.role
          when 'store_owner'
            'store'
          when 'user'
            'user'
          else 'store'
        end
      end

    def after_sign_in_path_for(resource)
      home_page_url
    end

    def after_sign_out_path_for(resource_or_scope)
      session[:user_type] = current_user.role unless current_user.blank?
      home_page_url(true)
    end

    # This method will check the url
    # If the url contains the keyword 'pro' then the user is a pro
    # otherwise if the url contains the keyword 'user', then it's a user
    # This information is stored in a session variable so that it can be easily used everywhere in the app
    def set_user_type
      # as sign_in path is shared by both, and is in the form of users/sign_in
      # just return when user gets this url
      url_elements = request.fullpath.split("/")
      return if url_elements.include?("sign_in")
      if url_elements.include?("user")
        session[:user_type] = USER_TYPES[:usr]
      elsif url_elements.include?("pro")
        session[:user_type] = USER_TYPES[:pro]
      end
    end

    # This method is called after an access denied exception by CanCan
    # It will redirect the user to the right place, whether it's a merchant account or a regular user.
    def redirect_after_access_denied
      if not current_user or current_user.user?
        redirect_to '/user', notice: t('cancan.access_denied')
      else
        redirect_to '/pro', notice: t('cancan.access_denied')
      end
    end
end
