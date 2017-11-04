class Board < ApplicationRecord
  TRELLO_BOARD_ATTRS = %i{tid name description}

  belongs_to :user
  has_many :board_laws, inverse_of: :board
  has_many :violations, inverse_of: :board

  validates_presence_of :user, :board_tid
  validates_uniqueness_of :board_tid

  delegate *TRELLO_BOARD_ATTRS, to: :trello_board, allow_nil: true, prefix: false

  def trello_lists
    trello_client.get_lists(board_tid)
  end

  private

  def trello_board
    @trello_board ||= trello_client.get_board(board_tid)
  end

  def trello_client
    @trello_client ||= TrelloUtils.load_user_client(user)
  end
end

# == Schema Information
#
# Table name: boards
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  board_tid   :string           not null
#  webhook_tid :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_boards_on_user_id  (user_id)
#
