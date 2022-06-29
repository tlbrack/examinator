# frozen_string_literal: true

##
# Receives:
#   schedule_params: [ActionController::Parameters] with
#     first_name, last_name, phone_number
#
# Effects:
#   can create a new User if not encountered before
#
# Provides:
#   user: [User] - the user found or created
#
class FindOrCreateUser
  include Interactor


  def call
    context.user = User.find_or_create_by(
      first_name: context.schedule_params[:first_name],
      last_name: context.schedule_params[:last_name],
      phone_number: context.schedule_params[:phone_number]
    )

    context.fail!(error: "Failed to create user. #{context.user.errors.full_messages.join(' ')}") unless context.user&.persisted?
  end
end
