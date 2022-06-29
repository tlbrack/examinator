class ExamWindow < ApplicationRecord
  belongs_to :exam

  validate :logical_window

  scope :contains, ->(exam_time) {
    where('starts_at <= :exam_time AND :exam_time <= ends_at', exam_time: exam_time)
  }

  protected

  def logical_window
    return if self.starts_at <= self.ends_at

    errors.add(:starts_at, 'must at or before ends_at')
  end
end
