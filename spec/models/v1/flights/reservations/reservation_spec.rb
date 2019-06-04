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

require 'rails_helper'

RSpec.describe V1::Flights::Reservations::Reservation, type: :model do
  before do
    @reservation = FactoryBot.build(:v1_flights_reservations_reservation)
    # byebug
  end

  subject {@reservation}

  it {is_expected.to be_valid}
  it('should be saved') {expect(subject.save).to be}

  it {is_expected.to belong_to(:owner)}
  it {is_expected.to belong_to(:execution).without_validating_presence}

  it {is_expected.to respond_to(:reserved_at)}

  describe 'with unavailable seats on the execution' do
    before do
      @execution = @reservation.execution
      @r2 = @reservation.dup
      @r2.save!
      @execution.save!
      @execution.assigned_airplane.save!
      @execution.assigned_airplane.update_column(:seats, 1)
    end

    it {is_expected.not_to be_valid}
  end
end
