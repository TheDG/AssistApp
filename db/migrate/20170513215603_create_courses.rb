# Basic Course CRUD
class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.integer :teacher_id
      t.string :subject
      t.string :grade
      t.string :level

      t.timestamps
    end
  end
end
