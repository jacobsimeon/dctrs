class CreateDeactivations < ActiveRecord::Migration
  def change
    create_table :deactivations do |t|
      t.date :deactivated_on
      t.date :reactivated_on
      t.string :reason
      t.references :provider

      t.timestamps
    end
    add_index :deactivations, :provider_id
  end
end
