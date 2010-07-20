class Search < ActiveRecord::Base
	set_table_name "forums"
	def find_forums(string_search)
		forums_search = Forum.find(:all, :conditions=> ['name LIKE ?', "%#{string_search}%"] );
		return forums_search
	end
	def find_topics(string_search, time)
		topics_search=Topic.find(:all, :conditions=> ['name LIKE ? and create_time>?', "%#{string_search}%", time]);
		return topics_search
	end
	def find_messages(string_search, time)
		messages_search=Message.find(:all, :conditions=> ['create_time>?  and (name LIKE ? OR content LIKE ?)', time, "%#{string_search}%", "%#{string_search}%"])
		messages_search
	end
	def get_topics(string_search, message_flag, topic_flag, time)		
		case time
			when "day"
				min_time=Time.now - 1.day;
			when "week"
				min_time=Time.now - 1.week;
			when "month"
				min_time=Time.now - 1.month;
			else
				min_time=Time.now - 1.year;
		end
		if(topic_flag)
			topic_list=find_topics(string_search, min_time);
		else
			topic_list=Array.new;
		end
		if(message_flag)
			message_list=find_messages(string_search, min_time);
			for mes in message_list
				if (topic_list.nil?)||(topic_list.index(mes.topic).nil?)
					topic_list<<mes.topic
				end
			end
		end
		return topic_list
	end
end
