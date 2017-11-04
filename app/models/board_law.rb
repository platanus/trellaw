class BoardLaw < ApplicationRecord
  serialize :settings

  belongs_to :board

  validates :law, presence: true, existing_law: true
  validates_presence_of :board
  validate :settings_valid_for_selected_law
  validates_uniqueness_of :law, scope: [:board_id, :list_tid]

  delegate :description, :definition, :get_settings_error, :required_card_properties,
    :law_attributes, :law_violations, to: :law_instance, allow_nil: true, prefix: false

  def law_instance
    LawUtils.law_instance(law, settings)
  end

  def config
    law_instance.config.inject({}) do |memo, attribute|
      memo[attribute.name] = attribute.value
      memo
    end
  end

  private

  def settings_valid_for_selected_law
    return unless errors.empty?
    error = law_instance.get_settings_error
    errors.add(:settings, error) if error.present?
  end
end

# == Schema Information
#
# Table name: board_laws
#
#  id         :integer          not null, primary key
#  board_id   :integer
#  list_tid   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  law        :string
#  settings   :text
#
# Indexes
#
#  index_board_laws_on_board_id  (board_id)
#
