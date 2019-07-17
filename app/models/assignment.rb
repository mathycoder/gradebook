class Assignment < ApplicationRecord
  belongs_to :learning_target
  has_many :grades, validate: true, :dependent => :delete_all
  has_many :students, through: :grades
  accepts_nested_attributes_for :grades
  validates :name, presence: true, length: { maximum: 40 }
  validates :date, presence: true
  validates_associated :grades


  def grades_attributes=(grades_hash)
    #For a new record, I need to set all of the grades for all klasses attached to this assignment/LT
    #to nil.  Then, I can put the grades inputted on this form.
    grades_hash.each do |key, attributes|
      current_grade = Grade.find_by(student_id: attributes[:student_id], assignment_id: self.id)
      if current_grade
        current_grade.update(score: attributes[:score])
      else
        self.grades.build(score: attributes[:score], student_id: attributes[:student_id])
      end
    end
    set_remaining_scores_to_nil()
  end

  def set_remaining_scores_to_nil
    self.learning_target.students.each do |student|
      #binding.pry
      if !self.grades.find{|grade| grade.student == student} && !Grade.find_by(student_id: attributes[:student_id], assignment_id: self.id)
        self.grades.build(score: nil, student_id: student.id)
      end
    end
  end

  def date_display
    self.date.strftime('%b %e') if self.date
  end

  def klass_grades(klass)
    self.grades.joins(student: :klasses).where("klass_id = ?", klass.id)
  end

  def average(klass)
    grades = self.klass_grades(klass).map {|grade| grade.score}.flatten.compact
    if !grades.empty?
      avg = grades.sum / grades.length
      '%.2f' % avg
    else
      nil
    end
  end

end
