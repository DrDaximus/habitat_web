class ChangeProjectFieldTypes < ActiveRecord::Migration
  def change
  	change_column :projects, :added_by, :string
  end
end
