class CreateJobs < ActiveRecord::Migration
  def up
    create_table :jobs do |t|
      t.string :title
      t.string :source_domain
      t.string :source_url
      t.string :source_id
      t.integer :user_id
      t.text :json
      
      t.timestamps
    end
  end
  
  def down
    drop_table :jobs
  end
end
