class ChangeContractDateToTimestamp < ActiveRecord::Migration
  def change
  	change_column :projects, :contract_date, :datetime
  end
end
