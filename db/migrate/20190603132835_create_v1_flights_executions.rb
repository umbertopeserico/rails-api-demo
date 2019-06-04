class CreateV1FlightsExecutions < ActiveRecord::Migration[5.2]
  def change
    create_table :v1_flights_executions, id: false do |t|
      t.string :id, primary_key: true, null: false
      t.timestamps

      t.datetime :departure_time, null: false
      t.datetime :arrival_time, null: false
      t.monetize :price

      t.string :assigned_airplane_id, null: false
    end

    add_index :v1_flights_executions, :assigned_airplane_id
    add_foreign_key :v1_flights_executions, :v1_flights_airplanes, {
        column: :assigned_airplane_id,
        on_delete: :restrict,
        on_update: :cascade
    }
  end
end
