class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.string :number
      t.string :state
      t.references :specialty

      t.timestamps
    end
    add_index :licenses, :specialty_id
  end
end
