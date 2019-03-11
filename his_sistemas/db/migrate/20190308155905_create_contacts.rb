class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :lastname
      t.string :emailcontact
      t.string :company
      t.string :phone1
      t.string :phone2

      t.timestamps
    end
  end
end
