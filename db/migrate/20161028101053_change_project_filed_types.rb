class ChangeProjectFiledTypes < ActiveRecord::Migration
  def change
  	change_column :projects, :added_by, :string, :default => "Unknown"
  	change_column :projects, :job_type, :string
  end
end
