class Assignment < ApplicationRecord
  belongs_to :learning_target
  has_many :grades, validate: true, :dependent => :delete_all
  has_many :students, through: :grades
  accepts_nested_attributes_for :grades
  validates :name, presence: true
  validates :date, presence: true
  validates_associated :grades


  def grades_attributes=(grades_hash)
    grades_hash.each do |key, attributes|
      current_grade = Grade.find_by(student_id: attributes[:student_id], assignment_id: self.id)
      if current_grade
        current_grade.update(score: attributes[:score])
      else
        self.grades.build(score: attributes[:score], student_id: attributes[:student_id])
      end
    end
  end

  def date_display
    self.date.strftime('%b %e') if self.date
  end

  def klass_grades(klass)
    self.grades.includes(:student).select{|grade| klass.students.include?(grade.student) }
  end

  def average(klass)
    if !self.grades.empty?
      grades = self.klass_grades(klass).map {|grade| grade.score}.flatten.compact
      if !grades.empty?
        avg = grades.sum / grades.length
        '%.2f' % avg
      else
        nil
      end
    end
  end

end
