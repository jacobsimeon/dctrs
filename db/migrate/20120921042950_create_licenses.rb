class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.references :provider
      t.string :number
      t.string :state

      t.timestamps
    end
    add_index :licenses, :provider_id
  end
end
