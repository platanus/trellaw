require 'rails_helper'

describe ApplyViolations do
  disable_jobs AddCardCommentJob, RemoveCardCommentJob

  let(:board) { create(:board) }
  let(:comment) { 'im am the law!' }

  let(:detected_1) { build(:detected_violation, violation: 'foo', card_tid: 'foo_tid') }
  let(:detected_2) do
    build(:detected_violation, violation: 'bar', card_tid: 'bar_tid', comment: comment)
  end

  let(:detected_violations) { [detected_1, detected_2] }

  def perform
    described_class.for(board: board, detected_violations: detected_violations)
  end

  it "adds detected violations to board" do
    expect { perform }.to change { board.violations.count }.by 2

    expect(Violation.last.law).to eq detected_2.law
    expect(Violation.last.violation).to eq detected_2.violation
  end

  it "performs the AddCardCommentJob if detected violation provides a comment" do
    expect(AddCardCommentJob).to receive(:perform_later).with(instance_of(Violation), comment).once
    perform
  end

  context "when there are some active violations" do
    let!(:active_1) { create(:violation, board: board, violation: 'foo', card_tid: 'foo_tid') }
    let!(:active_2) { create(:violation, board: board, violation: 'baz', card_tid: 'baz_tid') }
    let!(:active_3) { create(:violation, board: board, violation: 'qux', comment_tid: 'tid') }

    it "adds only new violations to board" do
      expect { perform }.to change { board.violations.count }.by 1
    end

    it "marks undetected violations as finished" do
      expect { perform }.to change { active_2.reload.finished_at }.from(nil).to Time
    end

    it "performs RemoveCardCommentJob on each commented and undetected violation" do
      expect(RemoveCardCommentJob).to receive(:perform_later).with(active_3).once
      perform
    end
  end
end
