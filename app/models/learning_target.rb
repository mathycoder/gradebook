class LearningTarget < ApplicationRecord
  has_many :klass_learning_targets
  has_many :klasses, through: :klass_learning_targets

  has_many :assignments
  has_many :grades, through: :assignments

  #validates :description, :name, :choose_standard, presence: true
  #validates :standard_notation, format: { with: /CCSS/, message: "Select a standard beginning with CCSS" }

  def chronological_assignments
    self.assignments.sort_by{|assignment| assignment.date}
  end

  def graph_data
    #(x = dates of assignments, y = average score)
    self.assignments.map do |assignment|
      [assignment.date.strftime('%b %d, %Y'), assignment.average]
    end
  end

  def average
    averages = self.assignments.map{|assignment| assignment.average.to_f}
    if !averages.empty?
      avg = averages.sum / averages.length
      '%.2f' % avg
    else
      nil
    end
  end

end
