class AddDesignToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :design, :boolean
  end
end
