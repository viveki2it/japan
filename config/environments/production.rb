# -*- encoding : utf-8 -*-
Nextdoorz::Application.configure do
  config.cache_classes = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = true
  config.assets.compress = false
  config.assets.compile = false
  config.assets.digest = true
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.action_mailer.default_url_options = {:host => 'beta.jangalamarket.com'}
  config.paperclip_defaults = {
    :storage => :s3,
    #:bucket => 'jangala-staging',
    :bucket => 'jangala-pictures',
    :s3_credentials => {
      :access_key_id => 'AKIAI4LATB6WCP6PCH6Q',
      :secret_access_key => '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'
    },
    path: ":class/:attachment/:id/:style.:extension"
  }
end
