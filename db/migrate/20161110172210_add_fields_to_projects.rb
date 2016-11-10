class AddFieldsToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :complete, :boolean
  	add_column :projects, :deposit, :boolean
  	remove_column :projects, :customer
  end
end
