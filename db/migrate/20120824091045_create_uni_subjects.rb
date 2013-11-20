class CreateUniSubjects < ActiveRecord::Migration
  def change
    create_table :uni_subjects do |t|
      t.references :uni
      t.string :subject
      t.text :details
      t.integer :time

      t.timestamps
    end
    add_index :uni_subjects, :uni_id
  end
end
