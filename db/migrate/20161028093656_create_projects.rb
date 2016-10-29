class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :reference
      t.integer :added_by
      t.integer :job_type
      t.integer :stage, :default => 1
      t.decimal :quote, :default => 0
      t.date :start_date
      t.integer :team
      t.boolean :pif, :default => false
      t.boolean :contract, :default => false
      t.boolean :handled, :default => false
      t.boolean :q_sent, :default => false

      t.timestamps null: false
    end
  end
end
