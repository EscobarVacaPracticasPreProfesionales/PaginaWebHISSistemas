class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :pictures, 	null: false
      t.string :title, 		null: false
      t.text :description, 	null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
