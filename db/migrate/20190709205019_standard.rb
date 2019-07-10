class Standard < ActiveRecord::Migration[5.2]
  def change
    create_table :standards do |t|
      t.string :name
      t.string :description
      t.string :grade
      t.string :grade_id
      t.timestamps
    end
  end
end
