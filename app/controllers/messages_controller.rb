class MessagesController < ApplicationController
  def index
    @user = current_user
    @messages = policy_scope(Message).order(created_at: :desc)
    @messagesReceived = Message.joins(:item).where("items.user_id= ?", current_user).order(created_at: :desc)
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.item = Item.find(params[:item_id])

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
