class AddDefaultToQuoteInProjects < ActiveRecord::Migration
  def change
  	change_column_default(:projects, :quote, nil)
  end
end
