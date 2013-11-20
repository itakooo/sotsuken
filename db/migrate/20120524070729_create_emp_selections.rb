class CreateEmpSelections < ActiveRecord::Migration
  def change
    create_table :emp_selections do |t|
      t.references :emp
      t.integer :glouping
      t.date :start
      t.date :end
      t.string :location
      t.date :result_date
      t.boolean :result

      t.timestamps
    end
    add_index :emp_selections, :emp_id
  end
end
