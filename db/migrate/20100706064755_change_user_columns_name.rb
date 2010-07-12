class ChangeUserColumnsName < ActiveRecord::Migration
  def self.up
	rename_column :topics, :creator_id, :user_id
	rename_column :forums, :creator_id, :user_id
	rename_column :messages, :creator_id, :user_id
  end

  def self.down
	rename_column :forums, :user_id, :creator_id
	rename_column :topics, :user_id, :creator_id
	rename_column :messages, :user_id, :creator_id
  
  end
end

