class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  before_filter :authenticate_user!
  before_filter :get_admin, :only => [:destroy, :edit]
  # GET /messages/new
  # GET /messages/new.xml
  def new
		@message = Message.new
		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @message }
		end
  end

  # GET /messages/1/edit
  def edit
		@message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(:content=> params[:message][:content],
	:name=> params[:message][:name], 
	:topic_id=>params[:message][:topic_id],
	:create_time=>params[:message][:create_time],
	:user_id=>params[:message][:user_id])
	Topic.find(params[:message][:topic_id]).update_attribute(:last_edit,params[:message][:create_time])
    respond_to do |format|
      if @message.save
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to "/topics/#{@message.topic_id}" }
        format.xml  { render :xml => @message, :status => :created, :location => "/topics/#{@message.topic_id}" }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Message was successfully updated.'
        format.html { redirect_to(@message) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
		@message = Message.find(params[:id])
		@message.destroy

		respond_to do |format|
			format.html { redirect_to("../topics/#{@message.topic_id}" ) }
			format.xml  { head :ok }
		end
  end  
end
