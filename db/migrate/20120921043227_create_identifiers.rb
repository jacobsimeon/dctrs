class CreateIdentifiers < ActiveRecord::Migration
  def change
    create_table :identifiers do |t|
      t.references :provider
      t.string :identifier_type
      t.string :state
      t.string :issuer

      t.timestamps
    end
    add_index :identifiers, :provider_id
  end
end
