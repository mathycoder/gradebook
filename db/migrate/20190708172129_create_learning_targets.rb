class CreateLearningTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :learning_targets do |t|
      t.string :name
      t.string :level1
      t.string :level2
      t.string :level3
      t.string :level4

      #for the standard
      t.string :grade
      t.string :grade_id
      t.string :api_standard_id
      t.string :standard_notation
      t.string :alt_standard_notation
      t.string :description

      t.timestamps
    end
  end
end
