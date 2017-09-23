module Trellaw
  def self.define_law(_law_name, &block)
    ::LawDsl.new(_law_name, &block)
    nil
  end
end
