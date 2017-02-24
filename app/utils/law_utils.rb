module LawUtils
  extend self

  ACTIVE_LAWS = []

  def active_laws
    @active_laws ||= ACTIVE_LAWS.map { |n| LawService.new law_name: n }
  end
end
