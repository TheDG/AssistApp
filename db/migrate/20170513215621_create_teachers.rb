class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :rut, null: false

      t.timestamps
    end
  end
end
