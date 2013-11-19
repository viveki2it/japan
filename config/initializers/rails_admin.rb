# -*- encoding : utf-8 -*-
# RailsAdmin config file. Generated on August 18, 2012 21:52
# See github.com/sferik/rails_admin for more informations

require 'rails_admin/history_undo.rb'

RailsAdmin.config do |config|
  config.current_user_method { current_user } # auto-generated
  config.authorize_with :cancan

  # If you want to track changes on your models:
  # config.audit_with :history, User

  # Or with a PaperTrail: (you need to install it first)
  config.audit_with :paper_trail, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['JangalaMarket', 'Admin']

  config.actions do
    dashboard
    index
    new
    history_show
    history_index
    history_undo
    show
    edit
    delete
  end

  config.model Address do
    visible false
    nested do
      exclude_fields :store, :latitude, :longitude, :gmaps, :district
    end
  end

  config.model Deal do
    parent Store
    list do
      field :id
      field :store
      field :name
      field :slots
      field :normal_price
      field :discount_price
      field :starts_at
      field :ends_at
    end
    edit do
      exclude_fields :categories
    end
  end

  config.model News do
    parent Store
    list do
      field :id
      field :store
      field :title
      field :updated_at
    end
    edit do
      exclude_fields :categories
    end
  end

  config.model Picture do
    visible false
    nested do
      exclude_fields :decorated
    end
  end

  config.model Product do
    parent Store
    list do
      field :id
      field :store
      field :name
      field :price
      field :updated_at
    end
    edit do
      exclude_fields :categories
    end
  end

  config.model ScheduleItem do
    nested do
      field :effective_day, :enum do
        enum do
          ScheduleItem.effective_days_for_select
        end
      end
      field :discontinue_day, :enum do
        enum do
          ScheduleItem.discontinue_days_for_select
        end
      end
      field :start_at
      field :end_at
    end
  end
  config.model Store do
    configure :categories do
      inverse_of :stores
    end

    list do
      include_fields :id, :name, :user, :phone, :address
    end
    edit do
      exclude_fields :pictures, :news, :products, :deals
    end
    update do
      include_fields :pictures, :news, :products, :deals
    end
  end

  config.model User do
    edit do
      field :email
      field :password
      field :password_confirmation
      field :role, :enum do
        enum do
          User.roles_for_select
        end
      end
      field :followed_stores
    end
    list do
      field :id
      field :email
      field :role
      field :last_sign_in_ip
    end
  end

  config.model Category do
    configure :stores do
      inverse_of :categories
    end
    list do
      include_fields :id, :title, :permalink
    end
  end


end
