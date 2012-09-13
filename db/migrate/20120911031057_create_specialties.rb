class CreateSpecialties < ActiveRecord::Migration
  def change
    create_table :specialties do |t|
      t.references :provider
      t.references :taxonomy
      t.boolean :is_primary

      t.timestamps
    end
  end
end
