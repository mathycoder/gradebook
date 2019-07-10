class Standard < ActiveRecord::Migration[5.2]
  def change
    create_table :standards do |t|
      t.string :name
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
