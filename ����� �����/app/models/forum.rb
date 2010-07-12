class Forum < ActiveRecord::Base
	has_many :topics, :dependent=> :destroy;
	belongs_to :user
	def self.find_forums(string_search)
		forums_search = Forum.find(:all, :conditions=> ['name LIKE ?', "%#{string_search}%"] );
		return forums_search
	end
	def self.find_topics(string_search)
		topics_search=nil
		for forum1 in Forum.find(:all)			
			if topics_search.nil?
				topics_search=forum1.topics.find(:all, :conditions=> ['name LIKE ?', "%#{string_search}%"] );
			else
				for top in forum1.topics.find(:all, :conditions=> ['name LIKE ?', "%#{string_search}%"] )					
					topics_search<<top;
				end
			end			
		end
		topics_search
	end
	def self.find_messages(string_search)
		messages_search=Message.find(:all, :conditions=> ['name LIKE ? OR content LIKE ?', "%#{string_search}%", "%#{string_search}%"])
		messages_search
	end
	def self.get_topics(string_search)
		topic_list=find_topics(string_search);
		message_list=find_messages(string_search);
		for mes in message_list
			if (topic_list.index(mes.topic).nil?)
				topic_list<<mes.topic
			end
		end
		return topic_list
	end
end
