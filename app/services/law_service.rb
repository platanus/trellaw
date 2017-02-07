class LawService < PowerTypes::Service.new(:law_name)
  def available?
    law_class
    true
  rescue NameError
    false
  end

  def law_class
    @law_class ||= law_class_name.constantize
  end

  private

  def law_class_name
    "#{@law_name.camelize}Law"
  end
end
