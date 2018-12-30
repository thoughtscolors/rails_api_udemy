class UserSerializer < ActiveModel::Serializer
  attributes :id, :login, :url, :avatar_url, :name
end
