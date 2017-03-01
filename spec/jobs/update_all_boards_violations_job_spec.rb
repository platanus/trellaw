require 'rails_helper'

RSpec.describe UpdateAllBoardsViolationsJob, type: :job do
  let(:boards) { create_list(:board, 3) }

  it "creates a UpdateBoardViolationsJob for each board" do
    allow(Board).to receive(:find_each)
      .and_yield(boards[0])
      .and_yield(boards[1])
      .and_yield(boards[2])

    allow(UpdateBoardViolationsJob).to receive(:perform_later)

    UpdateAllBoardsViolationsJob.perform_later

    expect(UpdateBoardViolationsJob).to have_received(:perform_later)
      .with(boards[0]).ordered
    expect(UpdateBoardViolationsJob).to have_received(:perform_later)
      .with(boards[1]).ordered
    expect(UpdateBoardViolationsJob).to have_received(:perform_later)
      .with(boards[2]).ordered
  end
end
