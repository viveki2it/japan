# -*- encoding : utf-8 -*-
module StoreButtonsHelper
  # This helper will store buttons that are shared accross the app for stores

  def create_profile_button(text = "Créer un profil pro", color = "color3")
    link_to text, "#",
      :class => "btn big #{color} btn-profile", :data => { :signed_in => user_signed_in? }
  end
  
  ##
  # = Store Buttons
  # Buttons associated to products:
    # Add to jangalist button
  def jangalist_button
    active_class = (user_wishes_it?(@product)) ? "active" : ""
    store_button("+ Jangalist", "#", 
      {
        :custom_class => "color2 #{active_class}",
        :id => 'btn-jangalist',
        :button_name => "jangalist",
        :under_construction => false
      }, 
      {:deactivated => user_is_pro?})
  end
  
    # Recommend product button
  def recommend_button
    store_button("Recommander", "#", 
      { :id => "btn-recommend",
        :under_construction =>  false, 
        :button_name => "recommend"
      }, 
      {:deactivated => user_is_pro?})
  end
  
    # Buy product button
  def buy_button
    store_button("Acheter", "#", 
      {:custom_class => "red", 
        :id => "btn-buy", 
        :button_name => "buy",
        :unactive => true
      }, 
      {:deactivated => user_is_pro?})
  end
  
  # Create one store button, there are some options that can be overrided
  def store_button(text, url, custom_options = {}, custom_datas = {})
    options = { :custom_class => "", :method => :get, :title => "", :id => "",
        :signed_in_required => true, :unactive => false, :target => "_self",
        :button_name => "", :popup => ""}
    options = options.merge(custom_options)
    datas = {
      :deactivated => false, 
      :content => String.new,
      "signed-in-required" => false
    }
    datas = datas.merge(custom_datas)
    
    # set link classes
    a_class = "btn big"
    a_class += " under-construction" if options[:under_construction]
    a_class += " #{options[:custom_class]}" unless options[:custom_class].blank?
    
    # Set datas
    # This option must be set to true to deactivate the button
    if options[:signed_in_required] 
      datas["signed-in-required"] = "#{!user_signed_in?}"
      datas[:deactivated] = true unless user_signed_in?
    end 
    
    # Set data-content: 
    if options[:unactive]
      # The first words depend on who is seing the page and
      # if the functionality is in dev or not. 
      options[:title] = t("buttons.title.unactive")
      if user_is_pro?
        datas[:content] = t("buttons.tooltips.pro.shared.unactive")
        datas[:content] += t("buttons.tooltips.pro.unactive.#{options[:button_name]}")   
      else
        datas[:content] = t("buttons.tooltips.user.shared.unactive")
        datas[:content] += t("buttons.tooltips.user.unactive.#{options[:button_name]}")
      end
      datas[:deactivated] = true
    elsif user_is_pro?
      options[:title]   = t("buttons.title.active")
      datas[:content]  = t("buttons.tooltips.pro.shared.active")
      datas[:content]  += t("buttons.tooltips.pro.#{options[:button_name]}")
    end

    link_options = {
      :title => options[:title],
      :class => a_class,
      :data => datas,
      :method => options[:method],
      :id => options[:id],
      :target => options[:target]
    }
    if @edit_store_mode
      link_options[:popup] = options[:popup]
      link_options[:class] += " store-edit-button"
      link_options[:data][:deactivated] = true
    end 
    
    # Create the li_tag and the link
    content_tag :li do
      link_to(text, url, link_options.delete_if { |key, value| value.blank? }) 
    end
  end

  # Create the store buttons: 
  def store_buttons(store)
    li_tags = String.new
    # Create the ul tag
    content_tag :ul, :class => "btn-group-jpath" do
      # Create the "follow/unfollow" button
      follow_name = "Suivre"
      follow_method = :get
      if user_is_customer?
        if user_is_following_store?(store, true)
          follow_name = "Ne plus suivre"
          follow_url = "/stores/#{store.id}/follows"
          follow_method = :delete
        else
          follow_url = "/stores/#{store.id}/follows/new"
        end
      else
        follow_url = "/user/follow/#{store.id}"
      end
      
      # add the shared buttons
      li_tags += store_button(follow_name, follow_url, {
          :method => follow_method,
          :button_name => "follow"})
      
      if store.website_url.blank?
        website_url = "#"
        website_unactive = true
      else
        website_url = store.website_url
        website_unactive = false
      end
      if store.facebook_url.blank?
        facebook_url = "#"
        facebook_unactive = true
      else
        facebook_url = store.facebook_url
        facebook_unactive = false
      end
      
      li_tags += store_button("Site web", website_url, 
        {:button_name => "store_website", :target => "_blank",
          :popup => "website", :unactive => website_unactive})
      
      li_tags += store_button("Page Facebook", facebook_url, 
        {:button_name => "facebook_page", :target => "_blank", 
          :popup => "facebook", :unactive => facebook_unactive})
      
      # Return all the li_tags
      li_tags.html_safe
    end
  end
  
  # Create store entity buttons
  def store_entity_buttons(big = false)
    a_class = 'btn color3 link'
    a_class += " big" if big
    
    content_tag :ul, :class => "btn-group-jpath" do 
      li_tags = content_tag :li do 
        link_to 'un produit', '#', class: a_class + " add_products"
      end
      li_tags += content_tag :li do 
        link_to 'une promotion', '#', class: a_class + " add_deals" 
      end
      li_tags += content_tag :li do
        link_to 'une actualité', '#', class: a_class + " add_news"
      end
      li_tags.html_safe
    end.html_safe
  end

end
