class AddSpecialtyParent < ActiveRecord::Migration
  def up
    add_column :specialties, :parent_id, :integer
  end

  def down
    remove_column :specialties, :parent_id
  end
end
