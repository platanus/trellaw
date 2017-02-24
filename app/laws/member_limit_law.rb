class MemberLimitLaw
  def self.description
    'Max Members'
  end

  def self.get_settings_error(_settings)
    return 'limit is required' unless _settings.key? :limit
    return 'limit must be an integer' unless _settings[:limit].is_a? Integer
    return 'limit must be greater than 0' if _settings[:limit] <= 0
    nil
  end
end
