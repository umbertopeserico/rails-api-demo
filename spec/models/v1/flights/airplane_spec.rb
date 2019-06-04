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

require 'rails_helper'

RSpec.describe V1::Flights::Airplane, type: :model do
  before do
    @airplane = FactoryBot.build(:v1_flights_airplane)
  end

  subject {@airplane}

  it {is_expected.to be_valid}
  it('should be saved') {expect(subject.save).to be}

  it {is_expected.to validate_presence_of(:name)}
  it do
    is_expected.to validate_numericality_of(:seats)
                       .is_greater_than(0)
                       .only_integer
  end

  it {is_expected.to have_many(:planned_flight_executions)}
end
