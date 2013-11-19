# -*- encoding : utf-8 -*-
class Users::SessionsController < Devise::SessionsController

  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => @failure)
    scope = Devise::Mapping.find_scope!(resource_name)
    resource ||= resource_name
    sign_in(scope, resource) unless warden.user(scope) == resource
    respond_to do |format|
      format.html { respond_with resource, :location => after_sign_in_path_for(resource) }
      format.json { render :json => {:success => true, :location => stored_location_for(scope) || after_sign_in_path_for(resource)}}
    end
  end

  def failure
    return render:json => {:success => false, :errors => ["Mauvaise combinaison email et mot de passe."]}
  end
end
