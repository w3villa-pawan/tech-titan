# Load API configuration with ERB support for environment variables
require 'erb'

api_config_file = Rails.root.join('config', 'api_config.yml')
api_config_content = ERB.new(File.read(api_config_file)).result
API_CONFIG = YAML.load(api_config_content)[Rails.env]

# Configure Stripe
Stripe.api_key = API_CONFIG['stripe_secret_key']

# Validate that Stripe keys are present in production
if Rails.env.production? && (API_CONFIG['stripe_secret_key'].blank? || API_CONFIG['stripe_publishable_key'].blank?)
  raise "Stripe API keys must be set in environment variables for production"
end