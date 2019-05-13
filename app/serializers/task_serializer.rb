class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :done

  has_many :taggings
  has_many :tags
end
