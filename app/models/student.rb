class Student < ApplicationRecord
  has_many :klass_students
  has_many :klasses, through: :klass_students
  has_many :teacher_klasses, through: :klasses
  has_many :teachers, through: :teacher_klasses

  def full_name
    "#{self.last_name}, #{self.first_name}"
  end
end
