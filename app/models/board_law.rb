class BoardLaw < ActiveRecord::Base
  belongs_to :board

  validates_inclusion_of :law, in: LawService.available_laws
  validates_presence_of :board, :law, :list_tid
end

# == Schema Information
#
# Table name: board_laws
#
#  id         :integer          not null, primary key
#  board_id   :integer
#  list_tid   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  law        :string
#
# Indexes
#
#  index_board_laws_on_board_id  (board_id)
#
