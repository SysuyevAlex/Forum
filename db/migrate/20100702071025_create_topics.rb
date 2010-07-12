class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.integer :creator_id
      t.integer :forum_id
      t.string :name
      t.datetime :create_time
      t.datetime :last_edit

      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
