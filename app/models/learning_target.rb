class LearningTarget < ApplicationRecord
  has_many :klass_learning_targets
  has_many :klasses, through: :klass_learning_targets
  has_many :assignments, :dependent => :delete_all
  has_many :grades, through: :assignments
  belongs_to :standard
  accepts_nested_attributes_for :standard, :klasses
  validates :name, presence: true, length: { maximum: 50 }
  validates :level1, :level2, :level3, :level4, length: {maximum: 160}


  def klasses_attributes=(klasses_ids)
    klasses_ids["0"]["id"].each do |klass_id|
      new_klass = Klass.find_by(id: klass_id)
      if new_klass
        self.klasses << new_klass if !self.klasses.include?(new_klass)
      end
    end
  end

  def standard_attributes=(standard_hash)
    self.standard = Standard.find_by(id: standard_hash["id"])
  end

  def chronological_assignments
    self.assignments.sort_by{|assignment| assignment.date}
  end

  def students_chronological_grades(student)
    self.grades.includes(:assignment).where("student_id = ?", student.id).order(date: :asc)
  end

  def graph_data(klass, student=nil)
    data = self.assignments.map do |assignment|
      student_score = assignment.grades.where("student_id = ?", student.id).limit(1).first
      score = student_score.score if student_score
      student ? (score) : (score = assignment.average(klass))
      [assignment.date.strftime('%b %d, %Y'), score]
    end
    data.empty? ? [[0,0]] : data
  end

  def class_average(klass)
    averages = self.assignments.map{|assignment| assignment.average(klass).to_f}.compact
    if !averages.empty?
      avg = averages.sum / averages.length
      '%.2f' % avg
    else
      nil
    end
  end

  def student_average(student)
    grades = self.grades.where("student_id = ?", student.id)
    grades = grades.map {|grade| grade.score}.compact
    if !grades.empty?
      avg = grades.sum / grades.length
      '%.2f' % avg
    end
  end

  def percent_of_students_on_level(klass, level)
    level == 3.0? level_up = 1.1 : level_up = 1.0
    averages = klass.students.map{|student| student.average(self).to_f}.compact
    high_averages = averages.select{|average| average >= level && average < (level+ level_up)}
    percentage = (high_averages.length.to_f / averages.length.to_f)*100.to_i
    percentage = '%.1f' % percentage
    "#{percentage}\%"
  end

end
