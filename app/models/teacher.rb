class Teacher < ApplicationRecord
  has_many :teacher_klasses
  has_many :klasses, through: :teacher_klasses
  has_many :klass_students, through: :klasses
  has_many :students, through: :klass_students
  has_secure_password

  validates :name, length: { minimum: 3 }
  validates :email, length: { minimum: 3 }

  scope :busy, -> {joins(:teacher_klasses).group(:teacher_id).order('COUNT(klass_id) DESC').limit(1)}

  def all_klasses_except(klass)
    self.klasses.where("klass_id != ?", klass.id)
  end

  def klasses_in_alphabetical_order
    #self.klasses.sort_by{|klass| klass.name}
    self.klasses.order(name: :asc)
  end

  # def self.busy
  #   self.all.joins(:teacher_klasses).group(:teacher_id).order('COUNT(klass_id) DESC').limit(1)
  # end


  # Company
  # .left_joins(:jobs)
  # .group(:id)
  # .order('COUNT(jobs.id) DESC')
  # .limit(10)

  # def classes_sorted_by_period
  #   self.klasses.sorted_by_period
  # end
end
