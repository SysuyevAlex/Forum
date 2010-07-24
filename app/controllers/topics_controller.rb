class TopicsController < ApplicationController
before_filter :authenticate_user!, :except => [:show]
before_filter :get_admin, :only => [:destroy, :edit, :update]

  def show    
    begin
		@topic = Topic.find(params[:id])
	rescue
		flash[:notice]="Wrong Topic ID=#{params[:id]}"
		redirect_to :action=> :index
	end
  end

  def new
		@topic = Topic.new
  end

  def edit
		@topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new(params[:topic])
	if @topic.save
		@topic=Topic.new(:name=>params[:topic][:name],
			:forum_id => params[:topic][:forum_id],			
			:create_time=>params[:topic][:create_time],
			:last_edit => params[:topic][:last_edit])
		flash[:notice]="Successfully created topic";
		redirect_to "#{forums_path}/#{@topic.forum_id}"
	else
		redirect :action=> 'new';
	end
  end

  def update
    @topic = Topic.find(params[:id])
      if @topic.update_attributes(params[:topic])
        flash[:notice] = 'Topic was successfully updated.'
		redirect_to "#{forums_path}/#{@topic.forum_id}"
      else
        render :action => "edit"        
      end    
  end

  def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy		
		redirect_to "#{forums_path}/#{@topic.forum_id}"		
  end  
end
