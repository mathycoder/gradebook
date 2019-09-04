class Klass < ApplicationRecord
  has_many :klass_students
  has_many :students, through: :klass_students
  has_many :teacher_klasses
  has_many :teachers, through: :teacher_klasses
  has_many :klass_learning_targets
  has_many :learning_targets, through: :klass_learning_targets
  has_many :assignments, through: :learning_targets
  has_many :standards, through: :learning_targets
  has_many :grades, through: :assignments
  validates :name, presence: true, length: {maximum: 20}
  validates :grade, presence: true, length: {maximum: 10}
  validates :subject, presence: true, length: {maximum: 20}
  validates :period, presence: true, numericality: true, length: {maximum: 2}
  scope :sorted_by_period, -> {order(period: :asc)}

  def klass_name
    "Class #{self.name}"
  end

  def students_by_last_name
    self.students.order(last_name: :asc)
  end

  def student_bar_graph_data(student)
    data = self.learning_targets.map do |lt|
      {name: lt.name, data: {"Learning Targets": lt.student_average(student)}}
    end

    #gets rid of any learning targets without assignments yet
    data = data.filter do |item|
      !item[:data][:"Learning Targets"].nil?
    end
  end

  def student_bar_graph_colors
    colors = ["rgb(217, 106, 94)", "rgb(85, 170, 104)", "rgb(71, 125, 179)"]
    graph_colors = []
    self.learning_targets.length.times do |index|
      graph_colors << colors[index % 3]
    end
    graph_colors
  end

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
