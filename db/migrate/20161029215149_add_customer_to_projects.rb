class AddCustomerToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :customer, :string
  end
end
