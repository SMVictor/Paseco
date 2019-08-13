require_relative 'boot'

require 'rails/all'
require 'pdfkit'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PaSeCo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Change default .yml for error language.
    config.i18n.default_locale = :es

    config.middleware.use PDFKit::Middleware

  end
end
