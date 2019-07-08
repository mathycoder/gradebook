class CreateGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :grades do |t|
      t.decimal :score
      t.timestamps
    end
  end
end
