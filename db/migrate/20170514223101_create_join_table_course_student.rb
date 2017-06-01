# Joim table for students and courses
class CreateJoinTableCourseStudent < ActiveRecord::Migration[5.1]
  def change
    create_join_table :courses, :students do |t|
      t.integer :course_id
      t.integer :student_id
      # t.index [:course_id, :student_id]
      # t.index [:student_id, :course_id]
    end
  end
end
