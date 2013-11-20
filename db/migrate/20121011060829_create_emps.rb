class CreateEmps < ActiveRecord::Migration
  def change
    create_table :emps do |t|
      t.references :account
      t.string :name
      t.string :location
      t.boolean :glouping
      t.date :submit
      t.text :entrysheet
      t.text :impression
      t.text :advice

      t.timestamps
    end
    add_index :emps, :account_id
  end
end
