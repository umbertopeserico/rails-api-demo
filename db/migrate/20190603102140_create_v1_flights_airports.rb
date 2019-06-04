class CreateV1FlightsAirports < ActiveRecord::Migration[5.2]
  def change
    create_table :v1_flights_airports, id: false do |t|
      t.string :id, primary_key: true, null: false
      t.timestamps

      t.string :name, null: false
    end

    add_index :v1_flights_airports, 'LOWER(name)',
              unique: true,
              name: :index_v1_flights_airports_on_LOWER_name
  end
end
