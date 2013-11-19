# -*- encoding : utf-8 -*-
class UsersMailer < Devise::Mailer
  #include MadMimiTwo
  HOST = ActionMailer::Base.default_url_options[:host]

  def send_store_invitation(user, store_mail)
    if user.blank? 
      user_name = "Un de vos clients"
      from = "hello@jangalamarket.com"
    else
      user_name = user.fullname
      from = user.email
    end
    
    options = { 
      "promotion_name" => "Invitation à Jangala Market Store", 
      "recipients" => store_mail, 
      "from" => "#{user_name if user} <#{from}>", 
      "subject" => "Invitation à Jangala Market Store" }
    yaml_body = { "fullname" => user_name }
    
    MAD_MIMI.send_mail(options, yaml_body)
  end

  def confirmation_instructions(record)
    if record.role == 'store_owner'
      confirm_store_owner user
    else
      devise_mail(record, :confirmation_instructions)
    end
  end

  def confirmation_successful(record)
    return unless record.role == 'store_owner'
    message = MadMimiMessage.new do
      subject "Welcome to Jangala Market"
      promotion "Your Profil Pro is Complete"
      to record.email
      from "noreply@jangalamarket.com"
      email_placeholders(
          email: record.email,
          local_store_name: record.store.name,
          store_edit_url: "<a href=\"http://jangalamarket.com/stores/#{record.store.id}/edit\">#{t(:edit_store)}</a>",
      )
    end
    message.deliver_mimi_message
  end

  def reset_password_instructions(record, opts={})
    if record.is_store_owner?
      reset_password_store_owner record
    else
      reset_password_user record
    end
  end
  
  def welcome(record)
    beta_link = "http://#{HOST}"
    password_link = "http://#{HOST}/users/password/new"
       
    options = {
      "promotion_name" => "User registration",
      "recipients" => record.email,
      "from" => "noreply@jangalamarket.com",
      "subject" => "Bienvenue sur Jangala Market !"
    }
    yaml_body = {
      "user_beta_link" => "<a href='" + beta_link + "'>Accédez à Jangala Market</a>",
      "email" => record.email,
      "password_link" => "<a href='" + password_link + "'>créer un nouveau mot de passe</a>"
    }
    MAD_MIMI.send_mail(options, yaml_body)
  end
  
  # See the views/shared/share_popup view form
  # Called from the users_controller#recommend action
  def recommend(user, params)
    from_email  = params[:r_email].to_s
    user_name   = user.nil? ? "Un ami" : user.fullname
    item_id     = params[:item_id].to_i
    
    case params[:item_type].to_s
    when "Product"
      item = Product.find(item_id)
      item_link      = product_url(item)
      promotion_name = "Recommend User Produit"
      subject        = "un produit"
      item_title     = item.name.titleize
      item_description = item.description
      
      yaml_body      = {
        :item_price => item.price
      }
    when "News"
      item           = News.find(item_id)
      item_link      = news_url(item)
      item_title     = item.title
      item_description = item.content

      promotion_name = "Recommend User Actualité"
      subject        = "une actualité"
      yaml_body      = Hash.new

    when "Deal"
      item           = Deal.find(item_id)
      item_link      = deal_url(item)
      item_title     = item.name
      item_description = item.description
      
      promotion_name = "Recommend User Promotion"
      subject        = "une bonne affaire"
      
      yaml_body      = {
        :new_price => item.discount_price,
        :percent_discount => item.discount_rate,
        :remaining_days  => item.remaining_days
      }
    else
      return false
    end
    # TODO: ne pas oublier de rétablier la récupération de l'image depuis AWS
    img_url = item.picture.image.url(:mail)
    #"http://jangala-staging.herokuapp.com/assets/image_example_middle.jpg"
    # item.picture.image.url(:mail)
    item_image = "<img style='margin-left: 10px; float: right; width: 157px;' " + 
      "alt='" + item_title + "' " + 
      "src='" +  img_url + "'>"  
    
    item_title_link = "<a href='" + item_link + "'>" + 
      item_title + "</a>"
    
    item_description = "<span style='margin: 0px; display: block; word-wrap: break-word; text-align: justify;'>" +
      item_description + "</span>"
    
    yaml_body = yaml_body.merge({
      :fullname         => user_name,
      :custom_message   => params[:r_message].to_s,
      :item_description => item_description,
      :item_title_link  => item_title_link,
      :item_image       => item_image
    })
    
    options = {
      :promotion_name => promotion_name,
      :recipients => params[:r_email2],
      :from       => from_email,
      :subject    => "Un ami vous recommande #{subject} sur Jangala Market"
    }
    MAD_MIMI.send_mail(options, yaml_body)
  end

  private

    def confirm_store_owner(user)
      message = MadMimiMessage.new do
        subject "Welcome to Jangala Market"
        promotion "Confirm Registration Email"
        to user.email
        from "noreply@jangalamarket.com"
        email_placeholders(
            email: user.email,
            local_store_name: user.store.name,
            store_edit_url: "<a href=\"http://jangalamarket.com/stores/#{user.store.id}/edit\">#{t(:edit_store)}</a>",
            password: user.password,
            confirmation_url: "http://jangalamarket.com/users/confirmation?confirmation_token=#{user.confirmation_token}"
        )
      end
      message.deliver_mimi_message
    end
  
    def reset_password_store_owner(user)
      edit_link = "http://#{HOST}/users/password/edit?reset_password_token=#{user.reset_password_token}"
       
      options = {
        "promotion_name" => "Lost Password Store ?",
        "recipients" => user.email,
        "from" => "noreply@jangalamarket.com",
        "subject" => "Instructions pour éditer votre mot de passe"
      }
      yaml_body = {
        "email" => user.email,
        "password_link" => "<a href='" + edit_link + "'>éditer votre mot de passe</a>", 
        "local_store_name" => user.store.name,
        "store_edit_url" => "<a href='" + edit_store_url(user.store) + "'>éditer votre magasin</a>"
      }
      MAD_MIMI.send_mail(options, yaml_body)
    end
    
    
    def reset_password_user(user)
      edit_link = "http://#{HOST}/users/password/edit?reset_password_token=#{user.reset_password_token}"
       
      options = {
        "promotion_name" => "Lost Password User ?",
        "recipients" => user.email,
        "from" => "noreply@jangalamarket.com",
        "subject" => "Instructions pour éditer votre mot de passe"
      }
      yaml_body = {
        "email" => user.email,
        "password_link" => "<a href='" + edit_link + "'>éditer votre mot de passe</a>"
      }
      MAD_MIMI.send_mail(options, yaml_body)
    end
end
