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

class V1::Flights::Reservations::Reservation < V1::ApplicationRecord
  #<editor-fold desc="Modules">
  self.table_name = V1::Flights::Reservations.table_name_prefix(no_last_underscore: true)
  include RandomId

  alias_attribute :reserved_at, :created_at
  #</editor-fold>

  #<editor-fold desc="Relations">
  belongs_to :owner,
             class_name: 'V1::Passengers::Passenger',
             inverse_of: :reservations

  belongs_to :execution,
             class_name: 'V1::Flights::Execution',
             inverse_of: :reservations
  #</editor-fold>

  #<editor-fold desc="Validations">
  validate do
    if self.execution.nil?
      self.errors.add(:execution, :invalid_execution)
    else
      if self.execution.available_seats <= 0
        self.errors.add(:execution, :seat_not_available, message: 'Seats not available')
      end
    end
  end
  #</editor-fold>

  #<editor-fold desc="Callbacks">

  #</editor-fold>

  #<editor-fold desc="Methods">

  private

  #</editor-fold>
end
