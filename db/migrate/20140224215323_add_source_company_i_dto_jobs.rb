class AddSourceCompanyIDtoJobs < ActiveRecord::Migration
  def up
    add_column :jobs, :source_job_id, :string
    add_column :jobs, :source_company_id, :string
  end
  
  def down
    remove_column :jobs, :source_job_id
    remove_column :jobs, :source_company_id
  end
    
end
