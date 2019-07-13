class Standard < ApplicationRecord

  def self.grades
    self.select('distinct grade')
  end

end
