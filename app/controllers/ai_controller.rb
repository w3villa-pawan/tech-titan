# app/controllers/ai_controller.rb
class AiController < ApplicationController
    skip_before_action :verify_authenticity_token # Allow POST requests from JavaScript
  
    def generate_description
      hotel_name = params[:name]
  
      client = Groq::Client.new
      prompt = "You are a hotel and property management bot which provide precise description based on Hotel name '#{hotel_name}' in about 100 words."
      response = client.chat(prompt)
  
      if response && response['content'].present?
        render json: { generated_text: response['content'] }
      else
        render json: { error: 'Failed to generate description' }, status: :unprocessable_entity
      end
    end
  end
  