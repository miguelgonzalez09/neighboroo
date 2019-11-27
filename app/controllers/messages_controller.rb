class MessagesController < ApplicationController
  def index
    @user = current_user
    @messages = policy_scope(Message).order(created_at: :desc)
    @messagesReceived = Message.joins(:item).where("items.user_id = ?", current_user).order(created_at: :desc)
    #@received_messages = Message.where(item_id: current_user.items.map {|item| item.id}).select {|message| message.user_id != current_user.id}

  end

  def index_thread
    @booking = Booking.new
    @sender = User.find(params[:user_id])
    @messages = policy_scope(Message).order(created_at: :desc)
    @messagesReceived = Message.joins(:item).where("items.user_id= ?", current_user).order(created_at: :desc)
    @message = Message.find(params[:message_id])

    authorize @message
  end

  def create
    @message = Message.new(message_params)
    if params[:item_id]
      @message.item_id = params[:item_id]
    elsif message_params[:item_id]
      message_params[:item_id] = Item.find(message_params[:item_id])
    end
    #@message.item = Message.find(message_params[:item_id]).item.id

    @message.user = current_user
    @message.save!

    redirect_to messages_path
    authorize @message
  end

  def destroy
    @message = Message.find(params[:message_id])
    @message.destroy
    redirect_to messages_path
    authorize @message
  end

  private

  def message_params
    params.require(:message).permit(:item_id, :user_id, :body)
  end
end
