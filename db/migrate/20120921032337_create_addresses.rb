class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_line
      t.string :second_line
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :fax
      t.references :provider

      t.timestamps
    end
  end
end
