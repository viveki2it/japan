##
## history_undo.rb
## Login : <lta@still>
## Started on  Mon Mar 18 12:18:14 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2013 Lta Akr

require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdminHistoryUndo
end

module RailsAdmin
module Config
module Actions

class HistoryUndo < RailsAdmin::Config::Actions::Base
  RailsAdmin::Config::Actions.register(self)

  register_instance_option :visible? do
    authorized? && bindings[:object].respond_to?(:versions) && bindings[:object].versions.any?
  end

  register_instance_option :member? do
    true
  end

  register_instance_option :link_icon do
    'icon-arrow-left'
  end

  register_instance_option :controller do
    Proc.new do
      @object.without_versioning do
        last = @object.previous_version
        @object.versions.last.destroy
        last.save
      end
      redirect_to_on_success
    end
  end
end

end end end
