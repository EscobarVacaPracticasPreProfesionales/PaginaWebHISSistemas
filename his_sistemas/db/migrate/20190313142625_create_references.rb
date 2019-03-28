class CreateReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :references do |t|
      t.string :title,    null: false
      t.string :content,  null: false
      t.integer :year,    null: false
      t.references :user, foreign_key: true
      t.references :picture, foreign_key: true

      t.timestamps
    end
  end
end
