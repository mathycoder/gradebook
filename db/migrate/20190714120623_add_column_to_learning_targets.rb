class AddColumnToLearningTargets < ActiveRecord::Migration[5.2]
  def change
    add_column :learning_targets, :standard_id, :integer
  end
end
