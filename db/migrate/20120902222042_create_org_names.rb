class CreateOrgNames < ActiveRecord::Migration
  def change
    create_table :org_names do |t|
      t.string :legal_business_name
      t.references :provider_organization
      t.timestamps
    end
  end
end
