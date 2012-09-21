class CreateOrgNames < ActiveRecord::Migration
  def change
    create_table :org_names do |t|
      t.string :legal_business_name
      t.string :name_type

      t.timestamps
    end
  end
end
