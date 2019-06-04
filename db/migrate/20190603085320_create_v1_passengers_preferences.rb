class CreateV1PassengersPreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :v1_passengers_preferences, id: false do |t|
      t.string :id, primary_key: true
      t.timestamps

      t.string :passenger_id, null: false
      t.string :language, null: false
      t.string :timezone, null: false
      t.string :currency, null: false
    end

    add_index :v1_passengers_preferences, 'LOWER(passenger_id)', unique: true,
              name: :index_v1_passengers_preferences_on_LOWER_passenger_id

    add_foreign_key :v1_passengers_preferences, :v1_passengers, {
        column: :passenger_id,
        on_update: :cascade,
        on_delete: :cascade
    }
  end
end
