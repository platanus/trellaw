class BoardLaw < ActiveRecord::Base
  serialize :settings

  belongs_to :board

  validates :law, presence: true, existing_law: true
  validates_presence_of :board
  validate :settings_valid_for_selected_law, if: 'errors.empty?'
  validates_uniqueness_of :law, scope: [:board_id, :list_tid]

  private

  def settings_valid_for_selected_law
    error = LawService.new(law_name: law).get_settings_error(settings)
    errors.add(:settings, error) if error.present?
  end
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
#  settings   :text
#
# Indexes
#
#  index_board_laws_on_board_id  (board_id)
#
