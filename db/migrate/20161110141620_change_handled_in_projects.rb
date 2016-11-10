class ChangeHandledInProjects < ActiveRecord::Migration
  def change
  	change_column :projects, :handled, :string
  end
end
