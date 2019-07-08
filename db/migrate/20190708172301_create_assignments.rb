class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.string :name
      t.datetime :date
      t.integer :learning_target_id
      t.timestamps
    end
  end
end
