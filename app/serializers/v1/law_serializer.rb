class V1::LawSerializer < ActiveModel::Serializer
  type :law

  attributes :name, :description, :definition, :law_attributes

  def law_attributes
    object.attributes
  end
end
