class CreateEmpInterviews < ActiveRecord::Migration
  def change
    create_table :emp_interviews do |t|
      t.references :emp_selection
      t.integer :candidates
      t.integer :examiners
      t.integer :time
      t.text :details

      t.timestamps
    end
    add_index :emp_interviews, :emp_selection_id
  end
end
