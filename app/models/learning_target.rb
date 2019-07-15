class LearningTarget < ApplicationRecord
  has_many :klass_learning_targets
  has_many :klasses, through: :klass_learning_targets
  has_many :assignments
  has_many :grades, through: :assignments
  belongs_to :standard
  accepts_nested_attributes_for :standard, :klasses
  validates :name, :standard_id, presence: true


  def klasses_attributes=(klasses_ids)
    klasses_ids.each do |klass_id|
      new_klass = Klass.find_by(id: klass_id[1]["id"])
      self.klasses << new_klass if !self.klasses.include?(new_klass)
    end

  end

  def standard_attributes=(standard_hash)
    self.standard = Standard.find_by(id: standard_hash["id"])
  end

  def chronological_assignments
    self.assignments.sort_by{|assignment| assignment.date}
  end

  def graph_data(klass)
    data = self.assignments.map {|assignment| [assignment.date.strftime('%b %d, %Y'), assignment.average(klass)]}
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

  def percent_of_students_on_level(klass, level)
    level == 3.0? level_up = 1.1 : level_up = 1.0
    averages = klass.students.map{|student| student.average(self).to_f}.compact
    high_averages = averages.select{|average| average >= level && average < (level+ level_up)}
    percentage = (high_averages.length.to_f / averages.length.to_f)*100.to_i
    percentage = '%.1f' % percentage
    "#{percentage}\%"
  end

end
