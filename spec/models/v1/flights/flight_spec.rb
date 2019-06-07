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

require 'rails_helper'

RSpec.describe V1::Flights::Flight, type: :model do
  before do
    @flight = FactoryBot.build(:v1_flights_flight)
  end

  subject {@flight}

  it {is_expected.to be_valid}
  it('should be saved') {expect(subject.save).to be}

  it {is_expected.to belong_to(:departure_airport)}
  it {is_expected.to belong_to(:arrival_airport)}

  it {is_expected.to have_many(:executions)}

  it {is_expected.to validate_presence_of(:departure_airport)}
  it {is_expected.to validate_presence_of(:arrival_airport)}

  it {is_expected.to validate_uniqueness_of(:arrival_airport_id).scoped_to(:departure_airport_id).case_insensitive}
  it {is_expected.to validate_uniqueness_of(:departure_airport_id).scoped_to(:arrival_airport_id).case_insensitive}

  describe 'with same arrival and departure' do
    before do
      subject.departure_airport_id = subject.arrival_airport_id
    end

    it {is_expected.not_to be_valid}
  end
end
