class CreateSpecialties < ActiveRecord::Migration
  def change
    create_table :specialties do |t|
      t.references :provider
      t.references :taxonomy
      t.boolean :is_primary

      t.timestamps
    end
    add_index :specialties, :provider_id
    add_index :specialties, :taxonomy_id
  end
end
