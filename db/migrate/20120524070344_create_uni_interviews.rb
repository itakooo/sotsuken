class CreateUniInterviews < ActiveRecord::Migration
  def change
    create_table :uni_interviews do |t|
      t.references :uni
      t.integer :candidates
      t.integer :examiners
      t.integer :time
      t.text :deatails

      t.timestamps
    end
    add_index :uni_interviews, :uni_id
  end
end
