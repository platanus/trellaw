class ApplyViolations < PowerTypes::Command.new(:board, :detected_violations)
  def perform
    violations = update_or_create_violations
    violation_ids = violations.map(&:id)
    finish_active_violations_except violation_ids
  end

  private

  def update_or_create_violations
    @detected_violations.map do |detected|
      violation = @board.violations.active.find_or_initialize_by(
        law: detected.law,
        violation: detected.violation,
        card_tid: detected.card_tid,
        list_tid: detected.list_tid
      )

      if violation.new_record?
        violation.started_at = Time.current
        violation.save!
        AddCardCommentJob.perform_later(violation, detected.comment) if detected.comment.present?
      end

      violation
    end
  end

  def finish_active_violations_except(_except_ids)
    @board.violations.active.where.not(id: _except_ids).each do |violation|
      violation.update_column(:finished_at, Time.current)

      if violation.comment_tid.present?
        RemoveCardCommentJob.perform_later(violation)
      end
    end
  end
end
