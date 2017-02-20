class Board < ActiveRecord::Base
  belongs_to :user
  has_many :board_laws, inverse_of: :board
  has_many :violations, inverse_of: :board

  validates_presence_of :user, :board_tid
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
