class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
	
      t.integer :creator_id
      t.integer :topic_id
      t.string :name
      t.text :content
      t.datetime :create_time

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
