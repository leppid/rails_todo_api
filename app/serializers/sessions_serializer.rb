class SessionsSerializer < ActiveModel::Serializer
  attributes :email, :activation_digest
end
