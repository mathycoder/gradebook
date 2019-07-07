class Teacher < ApplicationRecord
  has_many :teacher_klasses
  has_many :klasses, through: :teacher_klasses
  has_many :klass_students, through: :klasses
  has_many :students, through: :klass_students
end
