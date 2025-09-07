# app/controllers/ai_controller.rb
class AiController < ApplicationController
    before_action :authenticate_user!
    protect_from_forgery with: :exception
  
    def generate_description
      hotel_name = params[:name]
      
      # Input validation
      if hotel_name.blank?
        render json: { error: 'Hotel name is required' }, status: :bad_request
        return
      end
      
      # Sanitize input to prevent injection attacks
      sanitized_name = ActionController::Base.helpers.sanitize(hotel_name.strip)
      
      begin
        client = Groq::Client.new
        prompt = "You are a hotel and property management bot which provide precise description based on Hotel name '#{sanitized_name}' in about 100 words."
        response = client.chat(prompt)
    
        if response && response['content'].present?
          render json: { generated_text: response['content'] }
        else
          render json: { error: 'Failed to generate description' }, status: :unprocessable_entity
        end
      rescue StandardError => e
        Rails.logger.error "AI description generation failed: #{e.message}"
        render json: { error: 'Service temporarily unavailable' }, status: :service_unavailable
      end
    end
  end
  