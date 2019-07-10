class CreateLearningTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :learning_targets do |t|
      t.string :name
      t.string :level1
      t.string :level2
      t.string :level3
      t.string :level4
      t.timestamps
    end
  end
end
