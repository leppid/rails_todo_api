class TasksSerializer < ActiveModel::Serializer
  attributes :id, :title, :priority, :done
end
