# Represents a person taking an exam
class User < ApplicationRecord
  has_many :exams, through: :user_exams

  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :possible_phone_number

  protected

  # trying to be generous with allowed phone numbers
  # with more time, I would probably parse and store normalized in e164
  def possible_phone_number
    return if Phonelib.possible? phone_number

    errors.add(:phone_number, 'invalid.')
  end
end
