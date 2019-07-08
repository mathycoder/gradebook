class Assignment < ApplicationRecord
  belongs_to :learning_target
  has_many :grades
  has_many :students, through: :grades

  accepts_nested_attributes_for :grades

  def grades_attributes=(grades_hash)
    grades_hash.each do |key, attributes|
      self.grades.build(score: attributes[:score], student_id: attributes[:student_id])
    end
  end
end
