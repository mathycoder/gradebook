class CreateKlassLearningTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :klass_learning_targets do |t|
      t.integer :klass_id
      t.integer :learning_target_id
      t.timestamps
    end
  end
end
