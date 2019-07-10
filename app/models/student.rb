class Student < ApplicationRecord
  has_many :klass_students
  has_many :klasses, through: :klass_students
  has_many :teacher_klasses, through: :klasses
  has_many :teachers, through: :teacher_klasses

  has_many :grades

  def full_name
    "#{self.last_name}, #{self.first_name}"
  end

  def average(klass)
    if !klass.grades.empty?
      grades = klass.grades.where("student_id = ?", self.id).map{|grade| grade.score}.compact
      if !grades.empty?
        avg = grades.sum / grades.length
        '%.2f' % avg
      else
        nil
      end
    end
  end

  # def lt_average(klass, lt)
  #   binding.pry
  #   grades = lt.grades.where("student_id = ?", self.id).map{|grade| grade.score}.compact
  # end
end
