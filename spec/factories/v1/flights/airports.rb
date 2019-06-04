# == Schema Information
#
# Table name: v1_flights_airports
#
#  id         :string           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_v1_flights_airports_on_LOWER_name  (lower((name)::text)) UNIQUE
#

FactoryBot.define do
  factory :v1_flights_airport, class: 'V1::Flights::Airport' do
    name { FFaker::Address.city }
  end
end
