class Assistance < ActiveRecord::Migration[5.1]
  def change
    create_table :assistances do |t|
      t.timestamp :date
      t.boolean :attend
      
      t.timestamps
    end
  end
end
