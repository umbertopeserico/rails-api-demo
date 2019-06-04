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

class V1::Flights::Airport < V1::ApplicationRecord
  #<editor-fold desc="Modules">
  include RandomId
  #</editor-fold>

  #<editor-fold desc="Relations">
  has_many :arriving_flights,
           class_name: 'V1::Flights::Flight',
           foreign_key: :arrival_airport_id,
           dependent: :restrict_with_error,
           inverse_of: :arrival_airport

  has_many :departing_flights,
           class_name: 'V1::Flights::Flight',
           foreign_key: :departure_airport_id,
           dependent: :restrict_with_error,
           inverse_of: :departure_airport
  #</editor-fold>

  #<editor-fold desc="Validations">
  validates :name,
            presence: true,
            uniqueness: {case_sensitive: false}
  #</editor-fold>

  #<editor-fold desc="Callbacks">

  #</editor-fold>

  #<editor-fold desc="Methods">
  def to_s
    self.name
  end

  private

  #</editor-fold>

end
