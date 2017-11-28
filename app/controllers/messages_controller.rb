class MessagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_conversation

  # redirect_to this action from conversation controller create action
  def index
    # check if this current_user are involved in conversation
    if current_user == @conversation.sender || current_user == @conversation.recipient
      @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
      @messages = @conversation.messages.order("created_at DESC")
    else
      redirect_to conversations_path, alert: "他人のメッセージにアクセスできません"
    end

  end

  def create
    @message = @conversation.messages.new(message_params)
    @messages = @conversation.messages.order("created_at DESC")
    if @message.save
      #create.js.erb　が実行される
      respond_to do |format|
      if @message.moneygift.blank?
      else
        redirect_to root_path, notice: "お祝い金の申請承りました！スタッフが確認し次第スタッフのアカウントからメッセージをお送りさせていただきます！"
      end

      format.js
      end
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body, :user_id, :moneygift)
  end
end