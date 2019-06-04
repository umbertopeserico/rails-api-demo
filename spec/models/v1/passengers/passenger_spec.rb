# == Schema Information
#
# Table name: v1_passengers
#
#  id         :string           not null, primary key
#  email      :string           not null
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_v1_passengers_on_LOWER_email  (lower((email)::text)) UNIQUE
#

require 'rails_helper'

RSpec.describe V1::Passengers::Passenger, type: :model do
  before do
    @passenger = FactoryBot.build(:v1_passengers_passenger)
    @pref_attrs = FactoryBot.attributes_for(:v1_passengers_preference, passenger: @passenger)
    @passenger.build_preferences(@pref_attrs)
  end

  subject {@passenger}

  it {is_expected.to be_valid}

  it('should be saved') {expect(subject.save).to be}

  it {is_expected.to validate_presence_of(:first_name)}
  it {is_expected.to validate_presence_of(:last_name)}
  it {is_expected.to validate_presence_of(:email)}

  it {expect(subject).to validate_email_format_of(:email)
                             .with_message(I18n.t('activerecord.errors.messages.invalid_email'))}

  it {is_expected.to have_one(:preferences)}
  it {is_expected.to have_many(:reservations)}

  describe 'email downcased' do
    before do
      @email = 'EMAIL.NOT.DOWNCASED@foo.it'
      subject.email = @email
      subject.save
    end
    it {expect(subject.email).to be == @email.downcase}
  end

  describe 'full_name' do
    it {is_expected.to respond_to(:full_name)}

    it {expect(subject.full_name).to be == "#{subject.first_name} #{subject.last_name}"}
  end

  describe 'to_s method' do
    it 'should be equal to full_name' do
      expect(subject.to_s).to be == subject.full_name
    end
  end
end
