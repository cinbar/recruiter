class AddSourceTimestampsToJobs < ActiveRecord::Migration
  def up
    add_column :jobs, :source_created_at, :datetime
    add_column :jobs, :source_updated_at, :datetime
  end
  
  def down
    remove_column :jobs, :source_created_at
    remove_column :jobs, :source_updated_at
  end
end
