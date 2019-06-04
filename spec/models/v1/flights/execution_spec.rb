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

require 'rails_helper'

RSpec.describe V1::Flights::Execution, type: :model do
  before do
    @execution = FactoryBot.build(:v1_flights_execution)
  end

  subject {@execution}

  it {is_expected.to be_valid}
  it('should be saved') {expect(subject.save).to be}

  it {is_expected.to monetize(:price)}
  it {is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0)}
  it {is_expected.to belong_to(:assigned_airplane)}

  it {is_expected.to have_many(:reservations)}

  it {is_expected.to respond_to(:seats)}
  it {is_expected.to respond_to(:available_seats)}

  it {is_expected.to have_many(:reservations)}

  describe 'seats' do
    it('should be == assigned_airplane.seats') {expect(subject.seats).to be == subject.assigned_airplane.seats}
  end

  describe 'available seats' do
    before do
      subject.save!
      reservation = FactoryBot.build(:v1_flights_reservations_reservation)
      reservation.execution = subject
      reservation.save!
    end

    it('should be equal to seats - reservations.count') do
      expect(subject.available_seats).to be == subject.seats - subject.reservations.count
    end
  end
end
