require_relative 'boot'
require 'rails/all'
Bundler.require(*Rails.groups)

module Furima39415
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    
    # Enable the asset pipeline
    config.assets.enabled = true
  end
end