require 'clockwork'
require_relative './boot'
require_relative './environment'

module Clockwork
  error_handler do |error|
    Raven.capture_exception(error)
  end

  every(30.minutes, 'UpdateAllBoardViolationsJob') do
    UpdateAllBoardsViolationsJob.perform_later
  end
end
