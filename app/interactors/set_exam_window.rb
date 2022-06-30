# Receives:
#   schedule_params: [ActionController::Parameters] with start_time
#   exam: [Exam]
#
# Effects:
#   fails the context if invalid start time for the exam
#
# Provides:
#   start_time: [DateTime]
#
class SetExamWindow
  include Interactor

  before :parse_start_time

  def call
    context.exam_window = ExamWindow.contains(context.start_time).first
    context.fail!(error: 'No exam window is available for the start time') unless context.exam_window.present?
  end

  protected

  def parse_start_time
    context.start_time = DateTime.parse context.schedule_params[:start_time]
  rescue
    context.fail!(error: 'Unable to parse start time.  Try ISO 8601 format.')
  end
end
