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

  # POST /user_exams
  def create
    @user_exam = UserExam.new(user_exam_params)

    if @user_exam.save
      render json: @user_exam, status: :created, location: @user_exam
    else
      render json: @user_exam.errors, status: :unprocessable_entity
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
end
