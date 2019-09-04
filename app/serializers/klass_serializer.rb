class KlassSerializer < ActiveModel::Serializer
  attributes :id, :name, :subject, :grade, :period
  
end
