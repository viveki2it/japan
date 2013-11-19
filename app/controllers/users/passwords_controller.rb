class Users::PasswordsController < Devise::PasswordsController
  
  
  protected
  
    def after_sending_reset_password_instructions_path_for(resource_name)
      home_page_url
    end

end