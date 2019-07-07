class Student < ApplicationRecord
  has_many :klass_students
  has_many :klasses, through: :klass_students
  has_many :teacher_klasses, through: :klasses
  has_many :teachers, through: :teacher_klasses 
end
