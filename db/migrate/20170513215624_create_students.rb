# Basic Student CRUD
class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :name
      t.string :last_name
      t.string :rut, null: false

      t.timestamps
    end
  end
end
