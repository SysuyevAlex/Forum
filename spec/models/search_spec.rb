require 'spec_helper'
describe Search do
  def setup
		User.delete_all
		Forum.delete_all
		Topic.delete_all
		Message.delete_all  
		admin=User.create({:name=>'Admin', :email=>'probitiy@admin.ru', :password=>'11111', :password_confirmation=>'11111', :role=>1});
		user=User.create({:name=>'FirstUser', :email=>'probitiy@user.ru', :password=>'22222', :password_confirmation=>'22222', :role=>0});

		forums = Forum.create([{:name=>'First test forum', :create_time=>Time.now-3.month, :user_id=>admin.id},
			{:name=>'Forum form Seed', :create_time=>Time.now-2.week, :user_id=>admin.id},
			{:name=>'Last forum', :create_time=>Time.now, :user_id=>admin.id}]);
		topics = Topic.create([{:name=>'First topic', :create_time=>Time.now-1.month, :user_id=>user.id, :last_edit=>Time.now, :forum_id=>Forum.find(:first).id},
			{:name=>'Second Topic', :create_time=>Time.now-1.week, :user_id=>user.id, :last_edit=>Time.now, :forum_id=>Forum.find(:first).id},
			{:name=>'Third Topic', :create_time=>Time.now, :user_id=>user.id, :last_edit=>Time.now, :forum_id=>Forum.find(:first).id}]);
		messages = Message.create([{:name=>'About first topic',:content=>'Its hard to say something about it', :create_time=>Time.now-1.month, :user_id=>user.id, :topic_id=>Topic.find(:first).id},
			{:name=>'Answer N2',:content=>'Its my topic and I would happy to create something like it', :create_time=>Time.now-1.month, :user_id=>user.id, :topic_id=>Topic.find(:first).id},
			{:name=>'Admin Answer',:content=>'My Answer', :create_time=>Time.now-1.month, :user_id=>admin.id, :topic_id=>Topic.find(:first).id}]);

  end
  before(:all) do	
		@search=Search.new;
  end

  it "should find one topic with First" do
    @search.get_topics("First", nil, 1, "year").should_not eql(nil)
	@search.get_topics("First", nil, 1, "year").size.should eql(1)
	@search.get_topics("First", nil, 1, "year")[0].name.should eql ('First topic')
  end
  it "should find find two messages and only one topic" do
    @search.find_messages('o', Time.now-1.year).size.should eql(2);
    @search.get_topics('o', 1, nil, 'year').size.should eql(1);
  end
end
