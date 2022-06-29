class AddExamIdToExamWindows < ActiveRecord::Migration[7.0]
  def change
    add_reference :exam_windows, :exam, index: true
  end
end
