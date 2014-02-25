class AddCompanyQualityToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :company_rank, :integer
    add_column :jobs, :company_url, :string
  end
end
