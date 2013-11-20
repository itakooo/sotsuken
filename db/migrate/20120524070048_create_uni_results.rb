class CreateUniResults < ActiveRecord::Migration
  def change
    create_table :uni_results do |t|
      t.references :uni
      t.date :day
      t.boolean :result

      t.timestamps
    end
    add_index :uni_results, :uni_id
  end
end
