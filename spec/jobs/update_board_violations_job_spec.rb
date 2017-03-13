require 'rails_helper'

RSpec.describe UpdateBoardViolationsJob, type: :job do
  let(:board) { create(:board) }

  it "calls UpdateViolations commad for the board" do
    allow(UpdateViolations).to receive(:for)

    UpdateBoardViolationsJob.perform_now(board)

    expect(UpdateViolations).to have_received(:for)
      .with(board: board)
  end
end
