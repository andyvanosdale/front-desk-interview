class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :firstName
      t.string :lastName
      t.date :birthdate

      t.timestamps null: false
    end
  end
end
