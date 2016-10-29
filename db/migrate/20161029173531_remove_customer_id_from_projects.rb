class RemoveCustomerIdFromProjects < ActiveRecord::Migration
  def change
  	remove_column :projects, :customer_id
  end
end
