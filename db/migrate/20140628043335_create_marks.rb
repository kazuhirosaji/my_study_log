class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.string :date
      t.integer :subject_id

      t.timestamps
    end
  end
end
