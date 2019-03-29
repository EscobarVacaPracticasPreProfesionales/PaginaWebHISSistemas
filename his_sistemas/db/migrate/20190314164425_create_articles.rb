class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title,        null: false
      t.text :description,    null: false
      t.text :content,        null: false
      t.string :figcaption,   null: false
      t.date :fecha,          null: false
      t.references :user, foreign_key: true
      t.references :picture, foreign_key: true

      t.timestamps
    end
  end
end
