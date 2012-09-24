class CreateTaxonomies < ActiveRecord::Migration
  def change
    create_table :taxonomies do |t|
      t.string :code
      t.string :name
      t.text :description
      t.references :category
      t.references :parent_taxonomy

      t.timestamps
    end
    add_index :taxonomies, :category_id
    add_index :taxonomies, :parent_taxonomy_id
  end
end
