class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_admin, :only => [:destroy, :edit, :update]

  def new
		@message = Message.new
  end

  def edit
		@message = Message.find(params[:id])
  end

  def create
	@message = Message.new(params[:message])
	Topic.find(params[:message][:topic_id]).update_attribute(:last_edit,params[:message][:create_time])    
    if @message.save
        flash[:notice] = 'Message was successfully created.'
        redirect_to "#{forums_path}/#{@message.topic.forum_id}/topics/#{@message.topic_id}"
    else
        render :action => "new"
    end
  end

  def update
    @message = Message.find(params[:id])    
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Message was successfully updated.'
        redirect_to "#{forums_path}/#{@message.topic.forum_id}/topics/#{@message.topic_id}"
      else
        render :action => "edit"
      end
  end

  def destroy
		@message = Message.find(params[:id])
		@message.destroy
		redirect_to "#{forums_path}/#{@message.topic.forum_id}/topics/#{@message.topic_id}"
  end  
end
