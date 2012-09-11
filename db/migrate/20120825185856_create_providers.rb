class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :type
      t.timestamps
    end
  end
end
