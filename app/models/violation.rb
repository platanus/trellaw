class Violation < ActiveRecord::Base
  belongs_to :board

  validates :law, presence: true, existing_law: true
  validates_presence_of :board, :violation, :card_tid, :started_at

  scope :active, -> { where(finished_at: nil) }
end

# == Schema Information
#
# Table name: violations
#
#  id          :integer          not null, primary key
#  board_id    :integer
#  law         :string
#  violation   :string
#  card_tid    :string
#  list_tid    :string
#  comment_tid :string
#  started_at  :datetime
#  finished_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_violations_on_board_id_and_finished_at  (board_id,finished_at)
#  index_violations_on_card_tid                  (card_tid)
#
