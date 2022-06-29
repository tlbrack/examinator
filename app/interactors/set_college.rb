# frozen_string_literal: true

##
# Receives:
#   schedule_params: [ActionController::Parameters] with college_id
#   
# Effects:
#   fails the context if the college doesn't exist
#
# Provides:
#   college: [College]
#
class SetCollege
  include Interactor

  def call
    # not really needed downstream, but can return a better error if explicitly checking
    context.college = College.find_by(id: context.schedule_params[:college_id])
    
    context.fail!(error: 'College does not exist') unless context.college.present?
  end
end

