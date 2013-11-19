source 'https://rubygems.org'
# TODO: classify gems
# Get latest minor 3.2 rails version
gem 'rails', '~> 3.2'

gem 'rake', '10.0.2'


group :development do
  # Stop having to many logs about assets being loaded
  gem "quiet_assets", ">= 1.0.1" # https://github.com/evrone/quiet_assets
  gem 'ruby-progressbar' # https://github.com/jfelchner/ruby-progressbar
  gem 'rails_best_practices' # https://github.com/railsbp/rails_best_practices
  gem 'annotate' # Annotate models
  gem 'bullet' # Detect N+1 queries # https://github.com/flyerhzm/bullet
  # Better dev server
  gem 'thin'
  # Rails panel extention for Chrome: https://github.com/dejan/rails_panel
  gem 'meta_request'
end

gem 'jquery-rails'
gem 'bootstrap-sass', '~> 2.2'
gem 'haml-rails', '~> 0.4'

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'therubyracer'
  gem 'sqlite3'
end

group :test, :production do
  # App server for production
  gem 'unicorn'
end

group :test do
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
end

# Other gems
  # Use Postgresql everywhere, even in Dev. It's a better practice.
gem 'pg'

  # Authentication and roles management
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-tumblr'
gem "google-api-client", :require => "google/api_client"
gem "omniauth-google-oauth2"
gem "fb_graph"
gem "twitter_oauth"
gem "tumblr_wrapper"
gem "wordpress-com"
gem "blogger"
gem 'cancan'

  # Admin
gem 'rails_admin', '~> 0.4.5'
gem 'paper_trail'

  # Javascript / JSON
gem 'haml_coffee_assets'
gem 'backbone-on-rails'
gem 'backbone-support'
gem 'jquery-rails'
gem 'jquery-migrate-rails'
gem 'rabl'
gem 'oj'
gem 'gon'

  # Others
gem 'aws-sdk'
gem 'simple_enum'
gem 'paperclip'
gem 'kaminari'    # https://github.com/amatsuda/kaminari
gem 'ancestry'
gem 'gmaps4rails'
gem 'simple_form'

# Mails
gem 'madmimi'
#gem 'mad_mimi_two'

gem 'httpclient'
gem 'js-routes'
gem 'koala'
