class RemoveCustomerFromProjects < ActiveRecord::Migration
  def change
  	remove_column :projects, :customer_id
  	add_column :projects, :first_name, :string
  	add_column :projects, :last_name, :string
  	add_column :projects, :telephone, :string
  	add_column :projects, :post_code, :string
  	add_column :projects, :budget, :integer
  	add_column :projects, :when, :integer
  end
end
