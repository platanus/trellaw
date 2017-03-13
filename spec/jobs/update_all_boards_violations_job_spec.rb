require 'rails_helper'

RSpec.describe UpdateAllBoardsViolationsJob, type: :job do
  let(:boards) { create_list(:board, 3) }

  it "creates a UpdateBoardViolationsJob for each board" do
    allow(Board).to receive(:find_each)
      .and_yield(boards[0])
      .and_yield(boards[1])
      .and_yield(boards[2])

    UpdateAllBoardsViolationsJob.perform_now

    expect(UpdateBoardViolationsJob).to have_been_enqueued.with(boards[0])
    expect(UpdateBoardViolationsJob).to have_been_enqueued.with(boards[1])
    expect(UpdateBoardViolationsJob).to have_been_enqueued.with(boards[2])
  end
end
