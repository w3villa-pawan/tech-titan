class UsersController < ApplicationController
  before_action :authenticate_user!

  def previous_bookings
    @bookings = Booking.where(user_id: current_user.id)
  end

  def create_chat
    @selected_profile = User.find(params[:id])
    if @selected_profile.id == current_user.id
      flash[:alert] = "You cannot start a chat with yourself."
      redirect_to root_path and return
    end
    sender_id = current_user.id
    receiver_id = @selected_profile.id

    @chat = Chat.get_chat(sender_id, receiver_id)

    unless @chat
      @chat = Chat.create(sender_id: sender_id, receiver_id: receiver_id)
    end
    redirect_to user_chat_path(current_user, @chat)    
  end

  def index
    @users = User.all
  end
end