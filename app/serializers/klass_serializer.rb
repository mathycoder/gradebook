class KlassSerializer < ActiveModel::Serializer
  attributes :id, :name, :subject, :grade, :period
  has_many :students
  has_many :learning_targets
  has_many :teachers
  has_many :assignments
  has_many :grades, through: :assignments
end
