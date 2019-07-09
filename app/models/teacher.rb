class Teacher < ApplicationRecord
  has_many :teacher_klasses
  has_many :klasses, through: :teacher_klasses
  has_many :klass_students, through: :klasses
  has_many :students, through: :klass_students

  def classes_sorted_by_period
    self.klasses.sort_by{|klass| klass.period}
  end
end
