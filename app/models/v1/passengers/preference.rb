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

class V1::Passengers::Preference < V1::ApplicationRecord
  #<editor-fold desc="Modules">
  include RandomId
  #</editor-fold>

  #<editor-fold desc="Relations">
  belongs_to :passenger,
             class_name: 'V1::Passengers::Passenger',
             optional: false,
             inverse_of: :preferences
  #</editor-fold>

  #<editor-fold desc="Validations">
  validates :language,
            presence: true

  validates :timezone,
            presence: true,
            inclusion: ActiveSupport::TimeZone.all.map { |tz| tz.tzinfo.name }

  validates :currency,
            presence: true

  validates :passenger_id,
            uniqueness: {case_sensitive: false}

  validates :passenger,
            uniqueness: {case_sensitive: false}
  #</editor-fold>

  #<editor-fold desc="Callbacks">

  #</editor-fold>

  #<editor-fold desc="Methods">

  private

  #</editor-fold>

end
