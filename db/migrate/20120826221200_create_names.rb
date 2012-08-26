class CreateNames < ActiveRecord::Migration
  def up
    create_table :names do |t|
      t.string :first
      t.string :last
      t.references :provider

      t.timestamps
    end
    remove_column :providers, :name
  end

  def down
    drop_table :names
    change_table :providers do |t|
      t.string :name
    end
  end
end
