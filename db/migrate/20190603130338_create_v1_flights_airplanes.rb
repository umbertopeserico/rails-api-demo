class CreateV1FlightsAirplanes < ActiveRecord::Migration[5.2]
  def change
    create_table :v1_flights_airplanes, id: false do |t|
      t.string :id, primary_key: true, null: false
      t.timestamps

      t.string :name, null: false
      t.integer :seats, null: false, default: 0
    end
  end
end
