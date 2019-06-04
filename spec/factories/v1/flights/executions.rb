# == Schema Information
#
# Table name: v1_flights_executions
#
#  id                   :string           not null, primary key
#  arrival_time         :datetime         not null
#  departure_time       :datetime         not null
#  price_cents          :integer          default(0), not null
#  price_currency       :string           default("EUR"), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  assigned_airplane_id :string           not null
#
# Indexes
#
#  index_v1_flights_executions_on_assigned_airplane_id  (assigned_airplane_id)
#
# Foreign Keys
#
#  fk_rails_...  (assigned_airplane_id => v1_flights_airplanes.id) ON DELETE => restrict ON UPDATE => cascade
#

FactoryBot.define do
  factory :v1_flights_execution, class: 'V1::Flights::Execution' do
    departure_time { "2019-06-03 13:28:38" }
    arrival_time { "2019-06-03 16:28:38" }
    price { 10 }
    association :assigned_airplane, factory: :v1_flights_airplane, strategy: :create
  end
end
