class MessagesController < ApplicationController
  def new
    @messages = Message.all
    @message = Message.new
  end

  def create
    @message = Message.new(text: params[:message][:text])
    if @message.save
      # ActionCableで'message_channel'へ@messageを送信する。@messageはcontentに代入
      ActionCable.server.broadcast 'message_channel', content: @message
    end
  end


end
