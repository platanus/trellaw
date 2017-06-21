class UpdateBoardViolationsJob < ApplicationJob
  queue_as :default

  def perform(board)
    UpdateViolations.for board: board
  end
end
