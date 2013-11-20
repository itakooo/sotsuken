class CreateEmpSubmissions < ActiveRecord::Migration
  def change
    create_table :emp_submissions do |t|
      t.references :emp
      t.boolean :graduate
      t.boolean :result
      t.boolean :resume
      t.boolean :recommendation
      t.boolean :medical
      t.string :other

      t.timestamps
    end
    add_index :emp_submissions, :emp_id
  end
end
