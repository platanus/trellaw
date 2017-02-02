class Law < ActiveRecord::Base
  validates_presence_of :name
end

# == Schema Information
#
# Table name: laws
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
