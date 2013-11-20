class CreateEmpWebtests < ActiveRecord::Migration
  def change
    create_table :emp_webtests do |t|
      t.references :emp
      t.date :day
      t.string :location
      t.text :details

      t.timestamps
    end
    add_index :emp_webtests, :emp_id
  end
end
