class LawService < PowerTypes::Service.new(:law_name)
  def self.available_laws
    ['dummy']
  end

  def law_class
    @law_class ||= "#{@law_name.camelize}Law".constantize
  end
end
