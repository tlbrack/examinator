class Exam < ApplicationRecord
  belongs_to :college
  has_many :users, through: :user_exams
  has_many :exam_windows
end
