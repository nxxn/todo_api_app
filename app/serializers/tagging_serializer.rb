class TaggingSerializer < ActiveModel::Serializer
  attributes :tag_id, :task_id

  belongs_to :tag
  belongs_to :task
end
