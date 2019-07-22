class Teacher < ApplicationRecord
  has_many :teacher_klasses
  has_many :klasses, through: :teacher_klasses
  has_many :klass_students, through: :klasses
  has_many :students, through: :klass_students
  has_secure_password

  validates :name, length: { minimum: 3 }
  validates :email, length: { minimum: 3 }
  validates :password, length: { minimum: 8 }

  def classes_sorted_by_period
    self.klasses.sort_by{|klass| klass.period}
  end

  def all_klasses_except(klass)
    self.klasses.where("klass_id != ?", klass.id)
  end

  def klasses_in_alphabetical_order
    self.klasses.sort_by{|klass| klass.name}
  end
end
