# == Schema Information
#
# Table name: v1_flights_airplanes
#
#  id         :string           not null, primary key
#  name       :string           not null
#  seats      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :v1_flights_airplane, class: 'V1::Flights::Airplane' do
    name { FFaker::Vehicle.model }
    seats { 147 }
  end
end
