class Assignment < ApplicationRecord
  belongs_to :learning_target
  has_many :grades
  has_many :students, through: :grades

  accepts_nested_attributes_for :grades
end
