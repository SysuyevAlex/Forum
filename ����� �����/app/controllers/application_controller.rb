# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def search
	@search_string=params[:search]
	if (! (params[:search].blank?))
		@search_forums=Forum.find_forums(params[:search])
		@search_topics=Forum.get_topics(params[:search])
	else
		redirect_to(forums_path)
	end
  end 
def get_admin
  	if(current_user.role!=1)
		flash[:notice]="You don't have rights for this action"
		redirect_to (:controller=> "forums", :action=>"index")
	end
	
end
  
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
