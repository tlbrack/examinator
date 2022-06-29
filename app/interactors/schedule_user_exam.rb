# frozen_string_literal: true

##
# Receives:
#   schedule_params: [ActionController::Parameters]
#     {  
#        first_name: String, 
#        last_name: String, 
#        phone_number: String, 
#        college_id: Integer, 
#        exam_id: Integer, 
#        start_time: DateTime 
#     }  
#
# Effects:
#   can create a new User if not encountered before
#   creates a UserExam if successful
#
# Provides:
#   user: [User] - the user found or created
#   user_exam: [UserExam] - the scheduled examination instance
#   college: [College]
#   exam: [Exam]
#
class ScheduleUserExam
  include Interactor::Organizer

  organize [
    SetCollege,
    SetExam,
    SetExamWindow,
    FindOrCreateUser,
    CreateOrUpdateUserExam
  ]
end
