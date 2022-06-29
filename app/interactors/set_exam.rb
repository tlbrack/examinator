# frozen_string_literal: true

##
# Receives:
#   schedule_params: [ActionController::Parameters] with exam_id and college_id
#   
# Effects:
#   fails the context if exam is bad or not on the expected college
#
# Provides:
#   exam: [Exam]
#
class SetExam
  include Interactor

  def call
    context.exam = Exam.find(context.schedule_params[:exam_id])
    
    context.fail!(error: 'Exam not offered at this college') unless context.exam.college_id.same_as context.schedule_params[:college_id]
  end
end
