class Standard < ApplicationRecord
  has_many :learning_targets

  def self.grades
    self.select('distinct grade')
  end

  def self.by_grade(grade)
    self.where("grade = ? AND standard_notation LIKE ?", grade, "%Math.Content%").reverse
  end

  def standard_notation_clean
    self.standard_notation.split("CCSS.Math.Content.")[1]
  end

end
