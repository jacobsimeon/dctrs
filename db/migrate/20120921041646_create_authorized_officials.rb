class CreateAuthorizedOfficials < ActiveRecord::Migration
  def change
    create_table :authorized_officials do |t|
      t.references :name
      t.string :phone
      t.string :title

      t.timestamps
    end
    add_index :authorized_officials, :name_id
  end
end
