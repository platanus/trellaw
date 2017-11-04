module LawUtils
  extend self

  ACTIVE_LAWS = ['member_limit', 'max_days_on_list', 'card_limit']

  def active_laws
    @active_laws ||= ACTIVE_LAWS.inject([]) do |memo, law_name|
      memo << law_instance(law_name) if law_available?(law_name)
      memo
    end
  end

  def law_instance(_law_name, _settings = {})
    law_class(_law_name).new(_settings)
  end

  def law_class(_law_name)
    law_class_name(_law_name).constantize
  end

  def law_class_name(_law_name)
    "#{_law_name.to_s.camelize}Law"
  end

  def law_available?(_law_name)
    law_class(_law_name)
    true
  rescue NameError
    false
  end
end
