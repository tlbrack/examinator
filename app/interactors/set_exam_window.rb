# Receives:
#   schedule_params: [ActionController::Parameters] with start_time
#   exam: [Exam]
#
# Effects:
#   fails the context if invalid start time for the exam
#
# Provides:
#
class SetExamWindow
  include Interactor

  def call
    context.exam_window = ExamWindow.contains(DateTime.parse context.schedule_params[:start_time]).first
    context.fail!(error: 'No exam window is available for the start time') unless context.exam_window.present?
  end
end
