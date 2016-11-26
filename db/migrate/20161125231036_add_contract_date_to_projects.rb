class AddContractDateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :contract_date, :date
  end
end
