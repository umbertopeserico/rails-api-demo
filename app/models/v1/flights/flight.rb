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

class V1::Flights::Flight < V1::ApplicationRecord
  #<editor-fold desc="Modules">
  self.table_name = V1::Flights.table_name_prefix(no_last_underscore: true)
  include RandomId
  #</editor-fold>

  #<editor-fold desc="Relations">
  belongs_to :departure_airport,
             class_name: 'V1::Flights::Airport'

  belongs_to :arrival_airport,
             class_name: 'V1::Flights::Airport'

  has_many :executions,
           class_name: 'V1::Flights::Execution',
           inverse_of: :flight,
           dependent: :restrict_with_error
  #</editor-fold>

  #<editor-fold desc="Validations">
  validates :departure_airport,
            presence: true,
            uniqueness: {scope: :arrival_airport}

  validates :arrival_airport,
            presence: true,
            uniqueness: {scope: :departure_airport, case_sensitive: false}

  validates :departure_airport_id,
            presence: true,
            uniqueness: {scope: :arrival_airport_id, case_sensitive: false}

  validates :arrival_airport_id,
            presence: true,
            uniqueness: {scope: :departure_airport_id, case_sensitive: false}

  validate do
    if !self.departure_airport_id.nil? and !self.arrival_airport_id.nil? and
        self.departure_airport_id.to_s.downcase == self.arrival_airport_id.to_s.downcase
      self.errors.add(:departure_airport_id, :not_equal_to_arrival)
    end
  end

  validates :arrival_airport_id,
            presence: true,
            uniqueness: {scope: :departure_airport_id}
  #</editor-fold>

  #<editor-fold desc="Callbacks">

  #</editor-fold>

  #<editor-fold desc="Methods">
  def to_s
  end

  private

  #</editor-fold>

end
