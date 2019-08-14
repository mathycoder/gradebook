class Student < ApplicationRecord
  has_many :klass_students
  has_many :klasses, through: :klass_students
  has_many :teacher_klasses, through: :klasses
  has_many :teachers, through: :teacher_klasses
  has_many :grades

  validates :first_name, presence: true, length: {maximum: 20}
  validates :last_name, presence: true, length: {maximum: 20}
  validates :grade, presence: true, length: {maximum: 4}
  validates :klass, presence: true, length: {maximum: 5}



  def self.filter_by(query, klass)
    if query && !query.empty?
      students = self.where('first_name LIKE ? OR last_name LIKE ? OR klass LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%")
    else
      students = self.all.order(klass: :asc).order(last_name: :asc)
    end
    students = students - klass.students if klass
    students
  end

  def full_name
    "#{self.last_name}, #{self.first_name}"
  end

  def first_last_name
    "#{self.first_name} #{self.last_name}"
  end

  def current_grade(assignment)
    Grade.find_or_create_by(student_id: self.id, assignment_id: assignment.id)
  end

  def average(klass)
    grades = klass.grades.where("student_id = ?", self.id).map{|grade| grade.score}.compact
    if !grades.empty?
      avg = grades.sum / grades.length
      '%.2f' % avg
    else
      nil
    end
  end

  def percent_of_assignments_on_level(klass, level)
    level == 3.0? level_up = 1.1 : level_up = 1.0
    grades = klass.grades.where("student_id = ?", self.id)
    scores = grades.map{|grade| grade.score}.compact
    target_scores = scores.select{|score| score >= level && score < (level + level_up)}
    percentage = (target_scores.length.to_f / scores.length.to_f)*100.to_i
    percentage = '%.1f' % percentage
    "#{percentage}\%"
  end

end
