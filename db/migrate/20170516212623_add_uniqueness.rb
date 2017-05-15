class AddUniqueness < ActiveRecord::Migration[5.1]

  add_index :teachers, :rut, unique: true
  add_index :students, :rut, unique: true

end
