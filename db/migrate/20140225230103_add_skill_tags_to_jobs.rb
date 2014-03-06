class AddSkillTagsToJobs < ActiveRecord::Migration
  def up
    add_column :jobs, :skills, :text
  end
  
  def down
    remove_column :jobs, :skills
  end
end
