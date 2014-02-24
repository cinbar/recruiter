class AddJobFields < ActiveRecord::Migration
  def up
  	add_column :jobs, :hero_img, :string
  	add_column :jobs, :logo_img, :string
  	# i think this is title in DB already, but whatever, can figure out later
	add_column :jobs, :position, :string 
	add_column :jobs, :company, :string
	add_column :jobs, :location, :string
	add_column :jobs, :tags, :string
	add_column :jobs, :salary, :string
	add_column :jobs, :description, :string
	add_column :jobs, :connections, :string
	add_column :jobs, :skills, :string
  end
  def down 
  	remove_column :jobs, :hero_img
  	remove_column :jobs, :logo_img
	remove_column :jobs, :position
	remove_column :jobs, :company
	remove_column :jobs, :location
	remove_column :jobs, :tags
	remove_column :jobs, :salary
	remove_column :jobs, :description
	remove_column :jobs, :connections
	remove_column :jobs, :skills
  end
end
