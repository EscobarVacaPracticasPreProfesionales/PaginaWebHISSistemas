class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :files
      t.boolean :linked, default: false
      t.timestamps
    end
  end
end
