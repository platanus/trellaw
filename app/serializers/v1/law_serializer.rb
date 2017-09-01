class V1::LawSerializer < ActiveModel::Serializer
  type :laws

  attributes :name, :description, :law_attributes

  def law_attributes
    object.attributes
  end
end
