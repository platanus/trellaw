class UpdateViolations < PowerTypes::Command.new(:board, dry_run: false)
  def perform
    affected_lists.each do |list_tid|
      laws = laws_for_list(list_tid)

      cards = trello_client.get_list_cards(
        list_tid,
        properties: laws.map(&:required_card_properties).flatten.uniq
      )

      next if cards.empty?

      laws.each do |law|
        new_violations = law.check_violations(cards)
        new_violations.each { |v| v.list_tid = law.board_law.list_tid }
        violations.concat new_violations
      end
    end

    ApplyViolations.for(board: @board, detected_violations: violations) unless @dry_run
    violations
  end

  def affected_lists
    @affected_lists ||= begin
      if @board.board_laws.any? { |bl| bl.list_tid.nil? }
        trello_client.get_lists(@board.board_tid).map &:tid
      else
        @board.board_laws.map(&:list_tid).uniq
      end
    end
  end

  def laws_for_list(_list_tid)
    all_laws.select { |law| law.board_law.list_tid.nil? || law.board_law.list_tid == _list_tid }
  end

  def all_laws
    @all_laws ||= @board.board_laws.map { |bl| BoardLawWrapper.new(bl) }
  end

  def violations
    @violations ||= []
  end

  def trello_client
    @trello_client ||= TrelloUtils.summon_the_monkey
  end

  class BoardLawWrapper
    attr_reader :board_law

    def initialize(_board_law)
      @board_law = _board_law
    end

    def required_card_properties
      law_service.required_card_properties(@board_law.settings)
    end

    def check_violations(_list)
      law_service.check_violations(@board_law.settings, _list)
    end

    def law_service
      @law_service ||= LawService.new law_name: @board_law.law
    end
  end
end
