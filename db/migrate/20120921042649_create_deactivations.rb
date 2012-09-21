class CreateDeactivations < ActiveRecord::Migration
  def change
    create_table :deactivations do |t|
      t.date :deactivated_on
      t.date :reactivated_on
      t.string :reason
      t.references :provider

      t.timestamps
    end
  end
end
