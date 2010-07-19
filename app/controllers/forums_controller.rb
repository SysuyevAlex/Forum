class ForumsController < ApplicationController
  # GET /forums
  # GET /forums.xml
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :get_admin, :only => [:new, :destroy, :edit]
  def search	
	@messages=params[:search_message]
	@topics=params[:search_topic]
	@time=params[:search_time]
	if (! ((params[:search].blank?) || ((params[:search_message].nil?)&&(params[search_topic].nil?))) )
		#@search_forums=Forum.find_forums(params[:search])
		@search_topics=Forum.get_topics(params[:search], params[:search_message], params[:search_topic],params[:search_time])
	else
		redirect_to(forums_path)
	end
  end 
  def index
    @forums = Forum.find(:all)
    respond_to do |format|
      format.html # index.html.erb      
    end
  end

  # GET /forums/1
  # GET /forums/1.xml
  def show
    begin
		@forum = Forum.find(params[:id])
	rescue
		flash[:notice]="Wrong Forum ID=#{params[:id]}"
		redirect_to :action=> :index
	else
		respond_to do |format|
			format.html # show.html.erb			
		end
	end
  end

  # GET /forums/new
  # GET /forums/new.xml
  def new
		@forum = Forum.new

		respond_to do |format|
			format.html # new.html.erb			
		end
  end

  # GET /forums/1/edit
  def edit
		@forum = Forum.find(params[:id])
  end

  # POST /forums
  # POST /forums.xml
  def create
    @forum = Forum.new(params[:forum])

    respond_to do |format|
      if @forum.save
        flash[:notice] = 'Forum was successfully created.'
        format.html { redirect_to(@forum) }        
      else
        format.html { render :action => "new" }        
      end
    end
  end

  # PUT /forums/1
  # PUT /forums/1.xml
  def update
    @forum = Forum.find(params[:id])

    respond_to do |format|
      if @forum.update_attributes(params[:forum])
        flash[:notice] = 'Forum was successfully updated.'
        format.html { redirect_to(@forum) }        
      else
        format.html { render :action => "edit" }        
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.xml
  def destroy
		@forum = Forum.find(params[:id])
		@forum.destroy
		respond_to do |format|
			format.html { redirect_to(forums_url) }		
		end
	end
end
