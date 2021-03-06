module LawUtils
  extend self

  ACTIVE_LAWS = ['member_limit', 'max_days_on_list', 'card_limit']

  def active_laws
    @active_laws ||= ACTIVE_LAWS.map { |n| LawService.new law_name: n }
  end
end
