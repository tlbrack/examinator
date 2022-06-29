class UserExamsController < ApplicationController
  before_action :set_user_exam, only: %i[ show update destroy ]

  # GET /user_exams
  def index
    @user_exams = UserExam.all

    render json: @user_exams
  end

  # GET /user_exams/1
  def show
    render json: @user_exam
  end

  # Here's the specific endpoint requested in the challenge
  # technically, it creates OR updates
  # POST /user_exams
  def create
    result = ScheduleUserExam.call(schedule_params: schedule_params)

    if result.success?
      render json: result[:user_exam]
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_exams/1
  def update
    if @user_exam.update(user_exam_params)
      render json: @user_exam
    else
      render json: @user_exam.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_exams/1
  def destroy
    @user_exam.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_exam
      @user_exam = UserExam.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_exam_params
      params.require(:user_exam).permit(:starts_at)
    end

    # params allowed per the challenge
    # {  
    #    first_name: String, 
    #    last_name: String, 
    #    phone_number: String, 
    #    college_id: Integer, 
    #    exam_id: Integer, 
    #    start_time: DateTime 
    #  }  
    def schedule_params
      # get back a hash instead of an array when requiring multiple params
      # I might prefer moving the params under a 'user_exam' key, but sticking with requirements
      %i[first_name last_name phone_number college_id exam_id start_time].each_with_object(params) do |key, obj|
        obj.require(key)
      end
    end
end
