class AddSalaryMinMaxToJobs < ActiveRecord::Migration
  def up
    add_column :jobs, :salary_min, :string
    add_column :jobs, :salary_max, :string
    add_column :jobs, :equity_min, :string
    add_column :jobs, :equity_max, :string
  end
  
  def down
    remove_column :jobs, :salary_min
    remove_column :jobs, :salary_max
    remove_column :jobs, :equity_min
    remove_column :jobs, :equity_max
  end
end
