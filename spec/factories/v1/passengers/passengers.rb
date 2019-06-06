# == Schema Information
#
# Table name: v1_passengers
#
#  id              :string           not null, primary key
#  email           :string           not null
#  first_name      :string
#  last_name       :string
#  password_digest :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_v1_passengers_on_LOWER_email  (lower((email)::text)) UNIQUE
#

FactoryBot.define do
  factory :v1_passengers_passenger, class: 'V1::Passengers::Passenger' do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    password {'Ciao1234'}
    password_confirmation {'Ciao1234'}

    trait :with_preferences do
      association :preferences, factory: 'v1_passengers_passenger'
    end
  end
end
