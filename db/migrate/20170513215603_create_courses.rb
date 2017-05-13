class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :teacher
      t.string :subject
      t.string :grade
      t.string :level

      t.timestamps
    end
  end
end
