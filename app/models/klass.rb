class Klass < ApplicationRecord
  has_many :klass_students
  has_many :students, through: :klass_students

  has_many :teacher_klasses
  has_many :teachers, through: :teacher_klasses

  has_many :klass_learning_targets
  has_many :learning_targets, through: :klass_learning_targets
  has_many :assignments, through: :learning_tagets
  has_many :grades, through: :assignments 
end
