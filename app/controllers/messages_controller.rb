class MessagesController < ApplicationController
  def index
    @user = current_user
    @messages = policy_scope(current_user.messages).order(created_at: :desc)
    @messagesReceived = Message.where("receiver_id = ?", current_user.id).order(created_at: :desc)
    #@received_messages = Message.where(item_id: current_user.items.map {|item| item.id}).select {|message| message.user_id != current_user.id}

  end

  def index_thread
    @booking = Booking.new
    @sender = User.find(params[:user_id])
    @messages = policy_scope(current_user.messages).order(created_at: :desc)
    @messagesReceived = Message.where("receiver_id = ?", current_user.id).order(created_at: :desc)
    @message = Message.find(params[:message_id])
    @message_new = Message.new

    authorize @message
  end

  def thread_create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.save!
    
    redirect_to messages_path
    authorize @message
  end

  def create
    @message = Message.new(message_params)
    
    @message.item = Item.find(params[:item_id])
    @message.receiver = @message.item.user
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
    params.require(:message).permit(:item_id, :user_id, :body, :receiver_id)
  end
end
