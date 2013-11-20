class CreateEmpBriefings < ActiveRecord::Migration
  def change
    create_table :emp_briefings do |t|
      t.references :emp
      t.date :day
      t.string :location
      t.text :details

      t.timestamps
    end
    add_index :emp_briefings, :emp_id
  end
end
