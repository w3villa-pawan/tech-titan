# Load API configuration securely
API_CONFIG = Rails.application.config_for(:api_config)

# Set Stripe API key from secure configuration
Stripe.api_key = API_CONFIG['stripe_secret_key']