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

require 'rails_helper'

RSpec.describe V1::Passengers::Preference, type: :model do
  before do
    @passenger = FactoryBot.create(:v1_passengers_passenger)
    @pref = FactoryBot.build(:v1_passengers_preference, passenger: @passenger)
  end

  subject {@pref}

  it {is_expected.to be_valid}
  it('should be saved') {expect(subject.save).to be}

  it {is_expected.to validate_presence_of(:language)}
  it {is_expected.to validate_presence_of(:timezone)}
  it {is_expected.to validate_presence_of(:currency)}

  it {is_expected.to validate_uniqueness_of(:passenger_id).case_insensitive}
  it {is_expected.to validate_uniqueness_of(:passenger)}
  it {is_expected.to belong_to(:passenger).class_name('V1::Passengers::Passenger')}

  it {is_expected.to validate_inclusion_of(:timezone).in_array(ActiveSupport::TimeZone.all.map { |tz| tz.tzinfo.name })}
end
