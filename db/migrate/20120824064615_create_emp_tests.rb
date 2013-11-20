class CreateEmpTests < ActiveRecord::Migration
  def change
    create_table :emp_tests do |t|
      t.references :emp_selection
      t.integer :kind
      t.text :details

      t.timestamps
    end
    add_index :emp_tests, :emp_selection_id
  end
end
