class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    if params[:id].present?
      @chat = Chat.find(params[:id])
    end
    stream_for @chat
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
