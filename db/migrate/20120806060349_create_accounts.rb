class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :student_id
      t.string :name
      t.integer :major
      t.string :password
      t.boolean :admin

      t.timestamps
    end
  end
end
