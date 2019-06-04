class CreateV1FlightsReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :v1_flights_reservations, id: false do |t|
      t.string :id, primary_key: true
      t.timestamps

      t.string :owner_id
      t.string :execution_id, null: false
    end

    add_index :v1_flights_reservations, :owner_id
    add_foreign_key :v1_flights_reservations, :v1_passengers, {
        column: :owner_id,
        on_delete: :nullify,
        on_update: :cascade
    }

    add_index :v1_flights_reservations, :execution_id
    add_foreign_key :v1_flights_reservations, :v1_flights_executions, {
        column: :execution_id,
        on_delete: :restrict,
        on_update: :cascade
    }
  end
end

