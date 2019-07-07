class CreateKlassStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :klass_students do |t|
      t.integer :klass_id
      t.integer :student_id
      t.timestamps
    end
  end
end
