class ChnageColumnNameInProjectsContract < ActiveRecord::Migration
  def change
  	rename_column :projects, :contract, :contract_present
  end
end
