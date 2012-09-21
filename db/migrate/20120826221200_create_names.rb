class CreateNames < ActiveRecord::Migration
  def up
    create_table :individual_names do |t|
      t.string :first
      t.string :last
      t.string :middle
      t.string :prefix
      t.string :suffix

      t.timestamps
    end
  end

  def down
    drop_table :individual_names
  end
end
