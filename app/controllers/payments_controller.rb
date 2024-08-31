class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hotel_and_booking
  
  def new
    @payment = Payment.new
  end

  def create
    @amount = params[:amount].to_i * 100 # Convert to cents
  
    payment_intent = create_payment_intent

    if payment_intent.status.in?(['requires_action', 'requires_source_action'])
      render json: { client_secret: payment_intent.client_secret, redirect_url: payment_intent.next_action.redirect_to_url.url }
    else
      redirect_to root_path, notice: 'Payment successful!'
    end
      
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end

  def complete
    payment_intent = retrieve_payment_intent_from_params
    if payment_intent.status == 'succeeded' 
        if @payment
            @payment.update(payment_status: payment_intent.status, payment_date: Time.zone.now, amount: payment_intent.amount, payment_method: payment_intent.payment_method_types[0])
        else 
            finalize_payment(payment_intent)
            @payment.update(payment_status: payment_intent.status, payment_date: Time.zone.now, amount: payment_intent.amount, payment_method: payment_intent.payment_method_types[0])
        end

      redirect_to root_path, notice: 'Payment completed successfully!'
    else
      redirect_to order_failure_path, alert: 'Payment failed or was not completed.'
    end

  rescue Stripe::StripeError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end

  private

  def set_hotel_and_booking
    @hotel = Hotel.find(params[:hotel_id])
    @booking = Booking.find(params[:booking_id])
  end

  def create_payment_intent
    Stripe::PaymentIntent.create(
      amount: @amount,
      currency: 'inr',
      description: 'Test payment',
      payment_method: params[:payment_method_id],
      customer: create_customer(current_user).id,
      confirm: true,
      automatic_payment_methods: { enabled: true },
      return_url: complete_payment_url
    )
  end

  def complete_payment_url
    "#{API_CONFIG['host_url']}/hotels/#{@hotel.id}/bookings/#{@booking.id}/payments/complete"
  end

  def finalize_payment(payment_intent)
    @payment = Payment.create(
      booking: @booking,
      payment_intent_id: payment_intent.id,
      amount: payment_intent.amount,
      payment_status: payment_intent.status
    )
  end

  def retrieve_payment_intent_from_params
    # Assuming payment_intent_id is passed as a query parameter or similar
    Stripe::PaymentIntent.retrieve(params[:payment_intent])
  end

  def create_customer(user)
    Stripe::Customer.create({
      email: user.email,
      name: user.fullname,
      address: {
        city: 'Mumbai',
        country: 'India',
        line1: '123 Main St',
        line2: 'Unit 1'
      },
      metadata: { order_id: user.id }
    })
  end
end
