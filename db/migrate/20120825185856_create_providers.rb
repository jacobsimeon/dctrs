class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :type
      t.references :name

      t.timestamps
    end
  end
end
