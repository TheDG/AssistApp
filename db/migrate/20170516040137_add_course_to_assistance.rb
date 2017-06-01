# Not sure :/
class AddCourseToAssistance < ActiveRecord::Migration[5.1]
  def change
    change_table :assistances do |t|
      t.integer :course_id
    end
  end
end
