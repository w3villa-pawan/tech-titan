API_CONFIG = YAML.load_file(Rails.root.join('config', 'api_config.yml'))[Rails.env]

Stripe.api_key = API_CONFIG['stripe_secret_key']