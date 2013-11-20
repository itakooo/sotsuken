class CreateEmpEssays < ActiveRecord::Migration
  def change
    create_table :emp_essays do |t|
      t.references :emp_selection
      t.integer :time
      t.text :details

      t.timestamps
    end
    add_index :emp_essays, :emp_selection_id
  end
end
