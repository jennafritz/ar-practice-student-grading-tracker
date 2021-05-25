class CreateStudentExams < ActiveRecord::Migration[6.1]
  def change
    create_table :student_exams do |t|
      t.integer :grade
      t.string :teacher_comment
      t.integer :student_id
      t.integer :exam_id
    end
  end
end
