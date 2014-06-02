class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    add_index :subjects, [:user_id]
  end
end
