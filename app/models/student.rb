class Student < ActiveRecord::Base
  validates :last_name, presence: true
  validates :first_name, presence: true

  belongs_to :school
end
