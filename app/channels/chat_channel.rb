class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    reject and return unless params[:id].present?

    chat = Chat.find_by(id: params[:id])
    reject and return unless chat

    stream_for chat
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
