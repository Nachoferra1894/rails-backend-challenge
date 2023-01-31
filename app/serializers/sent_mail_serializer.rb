class SentMailSerializer < ActiveModel::Serializer
  attributes :from, :receiver, :subject, :body

  def from
    object.user.email
  end
end
