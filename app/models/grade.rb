class Grade < ApplicationRecord
  belongs_to :assignment
  belongs_to :student
  validates :score, numericality: {allow_nil: true, greater_than_or_equal_to: 1.0, less_than_or_equal_to: 4.0}
end
