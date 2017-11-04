class V1::BoardSerializer < ActiveModel::Serializer
  type :board

  attributes *Board::TRELLO_BOARD_ATTRS
  attributes :lists, :laws

  def lists
    object.trello_lists
  end

  def laws
    object.board_laws.map do |law|
      {
        id: law.id,
        law: law.law,
        settings: law.config
      }
    end
  end
end
