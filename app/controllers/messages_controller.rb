class MessagesController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!
  before_action :find_chat

  def create
    @message = @chat.messages.new(message_params)
    @message.sender_id = current_user.id
    @message.receiver_id = @chat.receiver_id

    if @message.save
      ChatChannel.broadcast_to(@chat, { mod_message: render_to_string(partial: 'message', locals: { message: @message }) })
      redirect_back fallback_location: user_chat_path(current_user, @chat)
    else
      flash[:alert] = @message.errors.full_messages.to_sentence
      redirect_back fallback_location: user_chat_path(current_user, @chat)
    end
  end

  private

  def find_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end

end