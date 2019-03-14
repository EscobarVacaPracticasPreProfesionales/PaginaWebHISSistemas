class CreateReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :references do |t|
      t.string :pictures
      t.string :title
      t.string :content
      t.integer :year
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
