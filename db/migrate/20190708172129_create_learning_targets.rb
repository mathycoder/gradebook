class CreateLearningTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :learning_targets do |t|
      t.integer :name
      t.timestamps
    end
  end
end
