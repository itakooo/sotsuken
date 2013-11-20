class CreateUniApps < ActiveRecord::Migration
  def change
    create_table :uni_apps do |t|
      t.references :uni
      t.date :start
      t.date :end

      t.timestamps
    end
    add_index :uni_apps, :uni_id
  end
end
