class ForumsController < ApplicationController
  before_filter :authenticate_user!, :only =>[:search]
  before_filter :get_admin, :except => [:show, :index, :search]
  def search
	s=Search.new
	if (! ((params[:search].blank?) || ((params[:search_message].nil?)&&(params[:search_topic].nil?))) )		
		@search_topics=s.get_topics(params[:search], params[:search_message], params[:search_topic],params[:search_time])
	else
		redirect_to(forums_path)
	end
  end 
  def index
    @forums = Forum.find(:all)
  end

  def show
    begin
		@forum = Forum.find(params[:id])
	rescue
		flash[:notice]="Wrong Forum ID=#{params[:id]}"
		redirect_to :action=> :index
	end
  end

  def new
		@forum = Forum.new
  end

  def edit
		@forum = Forum.find(params[:id])
  end

  def create
    @forum = Forum.new(params[:forum])
      if @forum.save
        flash[:notice] = 'Forum was successfully created.'
        redirect_to(@forum)
      else
        render :action => "new"
      end
  end

  def update
    @forum = Forum.find(params[:id])

      if @forum.update_attributes(params[:forum])
        flash[:notice] = 'Forum was successfully updated.'
		redirect_to(@forum)
      else
        render :action => "edit"
      end    
  end

  def destroy
		@forum = Forum.find(params[:id])
		@forum.destroy
		redirect_to(forums_url)	
  end
end
