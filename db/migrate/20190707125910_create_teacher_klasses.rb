class CreateTeacherKlasses < ActiveRecord::Migration[5.2]
  def change
    create_table :teacher_klasses do |t|
      t.integer :teacher_id
      t.integer :klass_id
      t.timestamps
    end
  end
end
