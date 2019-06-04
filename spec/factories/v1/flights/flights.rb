# == Schema Information
#
# Table name: v1_flights
#
#  id                   :string           not null, primary key
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  arrival_airport_id   :string           not null
#  departure_airport_id :string           not null
#
# Indexes
#
#  index_v1_flights_departure_id_arrival_id_1  (departure_airport_id,arrival_airport_id) UNIQUE
#  index_v1_flights_departure_id_arrival_id_2  (departure_airport_id,arrival_airport_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (arrival_airport_id => v1_flights_airports.id) ON DELETE => restrict ON UPDATE => cascade
#  fk_rails_...  (departure_airport_id => v1_flights_airports.id) ON DELETE => restrict ON UPDATE => cascade
#

FactoryBot.define do
  factory :v1_flights_flight, class: 'V1::Flights::Flight' do
    association :departure_airport, factory: :v1_flights_airport, strategy: :create
    association :arrival_airport, factory: :v1_flights_airport, strategy: :create
  end
end
