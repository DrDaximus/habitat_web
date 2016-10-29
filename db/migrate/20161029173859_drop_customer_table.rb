class DropCustomerTable < ActiveRecord::Migration
  def change
  	drop_table :customers
  end
end
