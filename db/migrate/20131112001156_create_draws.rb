class CreateDraws < ActiveRecord::Migration
  def change
    create_table :draws do |t|
      t.references :uni
      t.string :txt

      t.timestamps
    end
    add_index :draws, :uni_id
  end
end
