# == Schema Information
#
# Table name: v1_flights_reservations
#
#  id           :string           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  execution_id :string           not null
#  owner_id     :string
#
# Indexes
#
#  index_v1_flights_reservations_on_execution_id  (execution_id)
#  index_v1_flights_reservations_on_owner_id      (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (execution_id => v1_flights_executions.id) ON DELETE => restrict ON UPDATE => cascade
#  fk_rails_...  (owner_id => v1_passengers.id) ON DELETE => nullify ON UPDATE => cascade
#

FactoryBot.define do
  factory :v1_flights_reservations_reservation, class: 'V1::Flights::Reservations::Reservation' do
    association :owner, factory: :v1_passengers_passenger, :strategy => :create
    association :execution, factory: :v1_flights_execution, :strategy => :create
  end
end
