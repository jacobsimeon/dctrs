class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :type
      t.string :npi
      t.string :gender
      t.boolean :is_sole_proprietor
      t.boolean :is_organization_sub_part

      t.references :parent_provider
      t.references :name

      t.timestamps
    end
  end
end
