class TopicsController < ApplicationController
before_filter :authenticate_user!, :except => [:show]
before_filter :get_admin, :only => [:destroy, :edit, :update]
  # GET /topics
  # GET /topics.xml
  def index
    @topics = Topic.find(:all)

    respond_to do |format|
      format.html # index.html.erb      
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    
    begin
		@topic = Topic.find(params[:id])
	rescue
		flash[:notice]="Wrong Topic ID=#{params[:id]}"
		redirect_to :action=> :index
	else
		respond_to do |format|
			format.html # show.html.erb			
		end
	end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
		@topic = Topic.new

		respond_to do |format|
			format.html # new.html.erb			
		end
  end

  # GET /topics/1/edit
  def edit
		@topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.xml
  def create
    @topic = Topic.new(params[:topic])
	if @topic.save
		@topic=Topic.new(:name=>params[:topic][:name],
			:forum_id => params[:topic][:forum_id],			
			:create_time=>params[:topic][:create_time],
			:last_edit => params[:topic][:last_edit])
			flash[:notice]="Successfully created topic";
			redirect_to "/forums/#{@topic.forum_id}"
	else
		redirect :action=> 'new';
	end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = 'Topic was successfully updated.'
        format.html { redirect_to(@topic) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy

		respond_to do |format|
			format.html { redirect_to "../forums/#{@topic.forum_id}" }
			format.xml  { head :ok }
		end
    end  
end
