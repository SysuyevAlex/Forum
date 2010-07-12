class ChangeRole < ActiveRecord::Migration
  def self.up
	change_column :users, :role, :integer, :default => 0
  end

  def self.down
	raise ActiveRecord::IrreversibleMigration
  end
end
