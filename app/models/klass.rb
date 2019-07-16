class Klass < ApplicationRecord
  has_many :klass_students
  has_many :students, through: :klass_students

  has_many :teacher_klasses
  has_many :teachers, through: :teacher_klasses

  has_many :klass_learning_targets
  has_many :learning_targets, through: :klass_learning_targets
  has_many :assignments, through: :learning_targets
  has_many :grades, through: :assignments

  validates :name, presence: true, length: {maximum: 35}
  validates :grade, presence: true, length: {maximum: 20}
  validates :subject, presence: true, length: {maximum: 20}
  validates :period, presence: true, numericality: true, length: {maximum: 2}


  def my_color_class(lt)
    if lt != "new"
      lt_index = 0
      self.learning_targets.each_with_index do |learning_target, index|
        lt_index = index if learning_target == lt
      end
    else
      lt_index = self.learning_targets.length
    end

    if lt_index % 3 == 0
      "red"
    elsif lt_index % 3 == 1
      "green"
    else
      "blue"
    end
  end
end
