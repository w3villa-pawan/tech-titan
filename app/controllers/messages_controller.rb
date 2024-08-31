class MessagesController < ApplicationController
  before_action :find_chat

  def create
    @message = @chat.messages.new(message_params)
    @message.sender_id = current_user.id
    @message.receiver_id = @chat.receiver_id

    if @message.save
      ChatChannel.broadcast_to(
        @message.chat,
        render_to_string(partial: "message", locals: { message: @message })
      )
      head :ok
    else
      render json: { error: @message.errors.full_messages }, status: :unprocessable_entity
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