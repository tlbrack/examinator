class AddUserIdtoUserExams < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_exams, :user, index: true
    add_reference :user_exams, :exam, index: true
  end
end
