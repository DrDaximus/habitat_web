class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :team_name
      t.integer :team_no
      t.integer :team_leader

      t.timestamps null: false
    end
  end
end
