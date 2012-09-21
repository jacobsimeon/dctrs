class CreateTaxonomyGroups < ActiveRecord::Migration
  def change
    create_table :taxonomy_groups do |t|
      t.references :provider
      t.string :group

      t.timestamps
    end
    add_index :taxonomy_groups, :provider_id
  end
end
