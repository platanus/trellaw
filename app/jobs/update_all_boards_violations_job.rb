class UpdateAllBoardsViolationsJob < ActiveJob::Base
  queue_as :default

  def perform
    Board.find_each do |board|
      UpdateBoardViolationsJob.perform_later(board)
    end
  end
end
