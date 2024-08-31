# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    def new
      @payment = Payment.new
    end
  
    def create
      @root_url = "http://localhost:3000/"
      @amount = params[:amount].to_i * 100 # Convert to cents
  
      # Create a Payment Intent with automatic payment methods and a return URL
      payment_intent = Stripe::PaymentIntent.create(
        amount: @amount,
        currency: 'inr', # Use INR for payments in India
        description: 'Test payment',
        payment_method: params[:payment_method_id],
        customer: create_customer(current_user).id,
        # confirmation_method: 'manual',
        confirm: true,
        automatic_payment_methods: {
          enabled: true     },
        return_url: "#{@root_url}payments/complete" # Set your return URL here
      )
        @payment.assign_attributes(
        booking: current_user.bookings.last,
        payment_intent_id: payment_intent.id,
        amount: payment_intent.amount,
        payment_status: payment_intent.status
        )
      if payment_intent.status == 'requires_action' || payment_intent.status == 'requires_source_action'
        render json: { client_secret: payment_intent.client_secret, redirect_url: payment_intent.next_action.redirect_to_url.url }
      else
        @payment = Payment.create(
        booking: current_user.bookings.last,
        payment_intent_id: payment_intent.id,
        amount: payment_intent.amount,
        payment_status: payment_intent.status
        )
        redirect_to root_path, notice: 'Payment successful!'
      end      

      
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_payment_path
    end
  
    def complete
        if payment_intent.status == 'succeeded'
            @payment.update(payment_status: payment_intent.status, payment_date: Time.zone.now, amount: payment_intent.amount, payment_method: payment_intent.payment_method_types[0])
          redirect_to root, notice: 'Payment completed successfully!'
        else
          # Payment was not successful, handle failure actions here
          redirect_to order_failure_path, alert: 'Payment failed or was not completed.'
        end
      rescue Stripe::StripeError => e
        flash[:error] = e.message
        redirect_to new_payment_path
    end

    def create_customer current_user
        Stripe::Customer.create({
          email: current_user.email,
          name: current_user.fullname,
          address: {
            city: 'Mumbai',
            country: 'India',
            line1: '123 Main St',
            line2: 'Unit 1'
          },
          metadata: {
            order_id: current_user.id,
          }
        })
    end


end
  