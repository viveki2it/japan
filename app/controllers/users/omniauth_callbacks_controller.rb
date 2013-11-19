# -*- encoding : utf-8 -*-
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :omniauthcallbacks #, :except => ["google_oauth2"]

  def facebook
    if request.env['omniauth.params']['role'] == "user"
      action = request.env['omniauth.params'] && request.env['omniauth.params']['action'] ? request.env['omniauth.params']['action'] : nil
      role = request.env['omniauth.params']['role']
      unless ['signin', 'signup', 'connect'].include? action
        raise 'wrong parameters for facebook auth'
      end
      @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])
      @status = 'failed'
      @error = nil
      case action
      when 'signup'
        if @user
          @error = "Compte déja associé avec un autre utilisateur"
        elsif current_user
          @error = 'Vous êtes déja connecté'
        else
          @user = User.create_for_facebook_oauth(request.env["omniauth.auth"], role)
          sign_in @user
          redirect_to root_path
        end
      when 'signin'
        if !@user
          @error = 'Ce compte ne correspond a aucun utilisateur'
        elsif current_user
          @error = 'Vous êtes déja connecté'
        else
          @user.update_for_facebook_oauth(request.env["omniauth.auth"])
          sign_in @user
          redirect_to root_path
        end
      when 'connect'
        if @user
          if current_user && @user.id == current_user.id
            @error = 'Ce compte vous est déja associé'
          else
            @error = 'Ce compte est déja associé avec un autre utilisateur'
          end
        elsif !current_user || !current_user.id
          @error = 'Vous n\'êtes pas connecté'
        else
          @user = current_user
          @user.connect_for_facebook_oauth(request.env["omniauth.auth"])
          redirect_to user_profile
        end
      end
      if @error
        case action
        when 'signup'
          redirect_to user_signup_path(:error => @error)
        when 'signin'
          redirect_to user_signin_path(:error => @error)
        when 'connect'
          redirect_to edit_user_registration_path(:error => @error)
        end
      end
    end
  end

  def twitter
  end

  def tumblr
    #render :text => "<pre>"+request.env["omniauth.auth"].to_yaml+"</pre>"
  end

  private

  def omniauthcallbacks
    if current_user.is_store_owner?
      if params[:provider].present?
        @user_connect = Connection.find_for_oauth(request.env["omniauth.auth"], current_user)
        if @user_connect
          @user_connect.update_for_oauth(request.env["omniauth.auth"])
          redirect_to edit_user_registration_path
        else
          @user_connect = Connection.create_for_oauth(request.env["omniauth.auth"], current_user)
          redirect_to edit_user_registration_path
        end
      else
        redirect_to root_path
      end
    end
  end
 
  #
  #def twitter
  #  # You need to implement the method below in your model (e.g. app/models/user.rb)
  #  @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)
  #
  #  if @user.persisted?
  #    sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
  #    set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
  #  else
  #    session["devise.twitter_data"] = request.env["omniauth.auth"]
  #    redirect_to new_user_registration_url
  #  end
  #end
end
