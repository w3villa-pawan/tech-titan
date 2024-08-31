class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_chat, only: [:show]
  def index
    if current_user
      @user = current_user
      @chats = Chat.where("sender_id = ? OR receiver_id = ?", @user.id, @user.id).order("created_at DESC")
    else
      redirect_to login_path, notice: 'Please log in first.'
    end
  end

  def show
    @user = User.find(params[:user_id])
    @chat = Chat.find(params[:id])
    @message = Message.new
  end

  private

  def find_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:sender_id, :receiver_id)
  end
end