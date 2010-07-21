#User.delete_all
Forum.delete_all
Topic.delete_all
Message.delete_all

admin=User.create({:name=>'Admin', :email=>'probitiy@admin.ru', :password=>'11111', :password_confirmation=>'33333', :role=>1})
user=User.create({:name=>'FirstUser', :email=>'probitiy@user.ru', :password=>'22222', :password_confirmation=>'44444', :role=>0})

forums = Forum.create([{:name=>'First test forum', :create_time=>Time.now-3.month, :user_id=>admin.id},
			{:name=>'Forum form Seed', :create_time=>Time.now-2.week, :user_id=>admin.id},
			{:name=>'Last forum', :create_time=>Time.now, :user_id=>admin.id}])
topics = Topic.create([{:name=>'First topic', :create_time=>Time.now-1.month, :user_id=>user.id, :last_edit=>Time.now, :forum_id=>Forum.find(:first).id},
			{:name=>'Second Topic', :create_time=>Time.now-1.week, :user_id=>user.id, :last_edit=>Time.now, :forum_id=>Forum.find(:first).id},
			{:name=>'Third Topic', :create_time=>Time.now, :user_id=>user.id, :last_edit=>Time.now, :forum_id=>Forum.find(:first).id}])
messages = Message.create([{:name=>'About first topic',:content=>'Its hard to say something about it', :create_time=>Time.now-1.month, :user_id=>user.id, :topic_id=>Topic.find(:first).id},
			{:name=>'Answer N2',:content=>'Its my topic and I would happy to create something like it', :create_time=>Time.now-1.month, :user_id=>user.id, :topic_id=>Topic.find(:first).id},
			{:name=>'Админ негодует',:content=>'Хорош по буржуйскому писать. Всех забаню', :create_time=>Time.now-1.month, :user_id=>admin.id, :topic_id=>Topic.find(:first).id}])
