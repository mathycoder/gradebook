class Klass < ApplicationRecord
  has_many :klass_students
  has_many :students, through: :klass_students

  has_many :teacher_klasses
  has_many :teachers, through: :teacher_klasses
end
