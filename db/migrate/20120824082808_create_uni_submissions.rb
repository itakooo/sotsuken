class CreateUniSubmissions < ActiveRecord::Migration
  def change
    create_table :uni_submissions do |t|
      t.references :uni
      t.boolean :result
      t.boolean :survey
      t.boolean :recommendation
      t.string :other
      t.boolean :reason
      t.text :reason_details

      t.timestamps
    end
    add_index :uni_submissions, :uni_id
  end
end
