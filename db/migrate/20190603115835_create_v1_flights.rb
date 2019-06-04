class CreateV1Flights < ActiveRecord::Migration[5.2]
  def change
    create_table :v1_flights, id: false do |t|
      t.string :id, primary_key: true
      t.timestamps

      t.string :departure_airport_id, null: false
      t.string :arrival_airport_id, null: false
    end

    add_index :v1_flights, [:departure_airport_id, :arrival_airport_id],
              name: :index_v1_flights_departure_id_arrival_id_1,
              unique: true
    add_index :v1_flights, [:departure_airport_id, :arrival_airport_id],
              name: :index_v1_flights_departure_id_arrival_id_2,
              unique: true

    add_foreign_key :v1_flights, :v1_flights_airports, {
        column: :departure_airport_id,
        on_delete: :restrict,
        on_update: :cascade
    }

    add_foreign_key :v1_flights, :v1_flights_airports, {
        column: :arrival_airport_id,
        on_delete: :restrict,
        on_update: :cascade
    }
  end
end
