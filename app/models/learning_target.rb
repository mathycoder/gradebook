class LearningTarget < ApplicationRecord
  has_many :klass_learning_targets
  has_many :klasses, through: :klass_learning_targets

  has_many :assignments
  has_many :grades, through: :assignments

  def chronological_assignments
    self.assignments.sort_by{|assignment| assignment.date}
  end

end
