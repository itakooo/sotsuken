class CreateUnis < ActiveRecord::Migration
  def change
    create_table :unis do |t|
      t.references :account
      t.string :name
      t.string :major
      t.string :location
      t.boolean :glouping
      t.text :impression
      t.text :advice

      t.timestamps
    end
    add_index :unis, :account_id
  end
end
