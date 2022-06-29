# frozen_string_literal: true

##
# Receives:
#   schedule_params: [ActionController::Parameters]
#   user: [User]
#
# Effects:
#   creates a UserExam if not already scheduled
#   updates a UserExam if already scheduled
#
# Provides:
#   user_exam: [UserExam] - the scheduled examination instance
#
class CreateOrUpdateUserExam
  include Interactor

  before :set_user_exam

  def call
    context.user_exam.starts_at = context.schedule_params[:start_time]
    
    context.fail!(error: "Failed to schedule user for exam. #{context.user_exam.errors.full_messages.join(' ')}") unless context.user_exam.save
  end

  protected

  def set_user_exam
    context.user_exam = UserExam.find_or_initialize_by(
      user_id: context.user.id,
      exam_id: context.exam.id
    )
  end
end

