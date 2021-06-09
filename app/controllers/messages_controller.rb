class MessagesController < ApplicationController
  before_action :require_user
  def create
    @message = Message.new(params.require(:message).permit(:body))
    @message.user = current_user
    ActionCable.server.broadcast 'chatroom_channel', { mod_message: message_render(@message) } if @message.save
  end

  private
  
  def message_render(message)
    render(partial: "message", locals: {message: message})
  end
end
