class AddProvidersType < ActiveRecord::Migration
  def up
    add_column :providers, :type, :string
  end

  def down
  end
end
