class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name,         null: false
      t.string :lastname,     null: false
      t.string :emailcontact, null: false
      t.string :company,      null: false
      t.string :phone1,       null: false
      t.string :phone2,                  

      t.timestamps
    end
  end
end
