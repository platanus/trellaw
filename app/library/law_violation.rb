class LawViolation
  attr_reader :name, :law_name, :condition_proc, :comment_proc

  def initialize(_settings)
    @name = valid_name!(_settings[:name])
    @law_name = valid_law_name!(_settings[:law_name])
    @condition_proc = valid_condition_proc!(_settings[:condition_proc])
    @comment_proc = _settings[:comment_proc]
  end

  def check(_settings)
    set_violation_settings(_settings)
    build_detected_violation if !!condition_proc.call
  end

  def set_violation_settings(_settings)
    # Override on derived classes
  end

  private

  def build_detected_violation
    v = DetectedViolation.new
    v.law = law_name
    v.violation = name
    v.card_tid = detected_violation_card.tid
    v.comment = comment_proc.call || default_comment
    v
  end

  def detected_violation_card
    fail "you need to set detected_violation_card attribute" if @detected_violation_card.blank?
    @detected_violation_card
  end

  def default_comment
    I18n.t("laws.#{law_name}.violations.#{name}", default: "undefined violation default msg")
  end

  def valid_name!(_name)
    fail "violation name is required" if _name.blank?
    _name.to_s.to_sym
  end

  def valid_condition_proc!(_proc)
    fail "violation condition proc is required" unless _proc.is_a?(Proc)
    _proc
  end

  def valid_law_name!(_law_name)
    fail "valid law name is required" unless LawUtils.law_available?(_law_name)
    _law_name.to_sym
  end
end
