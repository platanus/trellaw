class UpdateViolations < PowerTypes::Command.new(:board, dry_run: false)
  def perform
    affected_lists.each do |list_tid|
      laws = laws_for_list(list_tid)
      cards = get_list_cards(list_tid, laws)
      next if cards.empty?
      laws.each { |law| load_law_violations(law, cards) }
    end

    ApplyViolations.for(board: @board, detected_violations: violations) unless @dry_run
    violations
  end

  private

  def get_list_cards(_list_tid, _laws)
    trello_client.get_list_cards(
      _list_tid,
      properties: _laws.map(&:required_card_properties).flatten.uniq
    )
  end

  def load_law_violations(_law, _cards)
    new_violations = []
    get_law_detected_violations(new_violations, _law, _cards)
    new_violations.each { |v| v.list_tid = _law.board_law.list_tid }
    violations.concat(new_violations)
  end

  def get_law_detected_violations(_new_violations, _law, _cards)
    _law.violations.each do |violation|
      case violation
      when LawViolations::CardViolation
        load_card_violations(_new_violations, violation, _cards, _law)
      when LawViolations::ListViolation
        load_list_violations(_new_violations, violation, _cards, _law)
      else
        fail "unknown law violation type"
      end
    end
  end

  def load_card_violations(_new_violations, _violation, _cards, _law)
    _cards.each do |card|
      v = _violation.check(card: card, attributes: _law.board_law.config)
      _new_violations << v if v
    end
  end

  def load_list_violations(_new_violations, _violation, _cards, _law)
    v = _violation.check(cards: _cards, attributes: _law.board_law.config)
    _new_violations << v if v
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
      law.required_card_properties
    end

    def violations
      law.law_violations
    end

    private

    def law
      board_law.law_instance
    end
  end
end
