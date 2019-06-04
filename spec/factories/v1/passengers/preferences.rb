# == Schema Information
#
# Table name: v1_passengers_preferences
#
#  id           :string           not null, primary key
#  currency     :string           not null
#  language     :string           not null
#  timezone     :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  passenger_id :string           not null
#
# Indexes
#
#  index_v1_passengers_preferences_on_LOWER_passenger_id  (lower((passenger_id)::text)) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (passenger_id => v1_passengers.id) ON DELETE => cascade ON UPDATE => cascade
#

FactoryBot.define do
  factory :v1_passengers_preference, class: 'V1::Passengers::Preference' do
    language {'it'}
    timezone {'Europe/Rome'}
    currency {'EUR'}

    trait :with_passenger do
      association :passenger, factory: 'v1_passengers_passenger'
    end
  end
end
