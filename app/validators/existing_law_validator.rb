class ExistingLawValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?

    unless LawService.new(law_name: value).available?
      record.errors[attribute] << (options[:message] || "law is not available")
    end
  end
end
