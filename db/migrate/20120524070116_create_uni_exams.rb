class CreateUniExams < ActiveRecord::Migration
  def change
    create_table :uni_exams do |t|
      t.references :uni
      t.date :start
      t.date :end

      t.timestamps
    end
    add_index :uni_exams, :uni_id
  end
end
