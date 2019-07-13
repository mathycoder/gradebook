class Standard < ApplicationRecord

  def self.grades
    self.select('distinct grade')
  end

  def self.by_grade(grade)
    self.where("grade = ?", grade).reverse
  end

end
