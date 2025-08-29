class BookingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_hotel, only: [:new, :create]
    before_action :set_booking, only: [:show, :edit, :update, :destroy]
  

    def index
      @bookings = Booking.all
    end

    def new
      @booking = @hotel.bookings.build
    end
  
    def create
      @booking = @hotel.bookings.build(booking_params)
      @booking.user = current_user
      @booking.status = 'pending'
      if @booking.save
        redirect_to new_hotel_booking_payment_path(@hotel, @booking), notice: 'Booking was successfully created.'
      else
        render :new
      end
    end
  
    def show
    end
  
    def edit
    end
  
    def update
      if @booking.update(booking_params)
        redirect_to @booking, notice: 'Booking was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @booking.destroy
      redirect_to bookings_url, notice: 'Booking was successfully canceled.'
    end
  
    private
  
    def set_hotel
      @hotel = Hotel.find(params[:hotel_id])
    end
  
    def set_booking
      @booking = Booking.find(params[:id])
    end
  
    def booking_params
      params.require(:booking).permit(:check_in, :check_out, :price, :status)
    end
  end
  