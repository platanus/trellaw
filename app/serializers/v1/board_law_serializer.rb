class V1::BoardLawSerializer < ActiveModel::Serializer
  type :board_law

  attributes :law, :list_tid, :settings
end
