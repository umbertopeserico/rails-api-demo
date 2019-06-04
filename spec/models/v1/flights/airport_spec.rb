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

require 'rails_helper'

RSpec.describe V1::Flights::Airport, type: :model do
  before do
    @airport = FactoryBot.build(:v1_flights_airport)
  end

  subject { @airport }

  it {is_expected.to be_valid}
  it('should be saved') {expect(subject.save).to be}

  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to validate_uniqueness_of(:name).case_insensitive}

  it {is_expected.to have_many(:arriving_flights)}
  it {is_expected.to have_many(:departing_flights)}

  describe 'to_s method' do
    it 'should be equal to name' do
      expect(subject.to_s).to be == subject.name
    end
  end
end
