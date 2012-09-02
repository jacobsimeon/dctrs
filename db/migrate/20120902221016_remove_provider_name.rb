class RemoveProviderName < ActiveRecord::Migration
  def up
    remove_column :providers, :full_name
  end

  def down
    add_column :providers, :full_name, :string
  end
end
