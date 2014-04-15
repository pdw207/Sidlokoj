class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable


  validates :first_name, presence: true
  validates :last_name, presence: true

  PASSWORD_REGEX = /\A[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})\z/

  validates :email,
    format: { with: PASSWORD_REGEX, message: "Not a valid email" }

  has_many :schools, foreign_key: "principal_id"
  belongs_to :school
  has_many :courses, foreign_key: "teacher_id"
  has_many :submitted_requests, foreign_key: 'teacher_id', class_name: 'Request'
  has_many :requests, foreign_key: 'principal_id'

  def full_name
    "#{first_name} #{last_name}"
  end
end

