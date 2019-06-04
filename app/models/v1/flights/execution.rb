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

class V1::Flights::Execution < V1::ApplicationRecord
  #<editor-fold desc="Modules">
  include RandomId
  monetize :price_cents
  #</editor-fold>

  #<editor-fold desc="Relations">
  belongs_to :assigned_airplane,
             class_name: 'V1::Flights::Airplane',
             inverse_of: :planned_flight_executions

  has_many :reservations,
           class_name: 'V1::Flights::Reservations::Reservation',
           inverse_of: :execution,
           foreign_key: :execution_id

  #</editor-fold>

  #<editor-fold desc="Validations">
  validates :price,
            numericality: {greater_than_or_equal_to: 0}
  #</editor-fold>

  #<editor-fold desc="Callbacks">

  #</editor-fold>

  #<editor-fold desc="Methods">

  def seats
    self.assigned_airplane.seats
  end

  def available_seats
    self.seats - self.reservations.count
  end

  private

  #</editor-fold>

end
