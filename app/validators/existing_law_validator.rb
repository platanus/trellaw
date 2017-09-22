class ExistingLawValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?

    if !LawUtils.law_available?(value)
      record.errors[attribute] << (options[:message] || "law is not available")
    end
  end
end
