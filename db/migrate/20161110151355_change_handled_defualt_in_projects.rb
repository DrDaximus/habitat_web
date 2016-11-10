class ChangeHandledDefualtInProjects < ActiveRecord::Migration
  def change
  	change_column_default(:projects, :handled, nil)
  end
end
