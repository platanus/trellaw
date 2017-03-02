class UpdateBoardViolationsJob < ActiveJob::Base
  queue_as :default

  def perform(board)
    UpdateViolations.for board: board
  end
end
