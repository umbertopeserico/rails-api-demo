class AddFlightIdToExecution < ActiveRecord::Migration[5.2]
  def change
    add_column :v1_flights_executions, :flight_id, :string, null: false

    add_index :v1_flights_executions, :flight_id
    add_foreign_key :v1_flights_executions, :v1_flights, {
        column: :flight_id,
        on_delete: :restrict,
        on_update: :cascade
    }
  end
end
