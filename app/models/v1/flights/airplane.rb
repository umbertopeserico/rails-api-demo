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

class V1::Flights::Airplane < V1::ApplicationRecord
  #<editor-fold desc="Modules">
  include RandomId
  #</editor-fold>

  #<editor-fold desc="Relations">
  has_many :planned_flight_executions,
           class_name: 'V1::Flights::Execution',
           dependent: :restrict_with_error,
           inverse_of: :assigned_airplane
  #</editor-fold>

  #<editor-fold desc="Validations">
  validates :name,
            presence: true

  validates :seats,
            presence: true,
            numericality: {only_integer: true, greater_than: 0}
  #</editor-fold>

  #<editor-fold desc="Callbacks">

  #</editor-fold>

  #<editor-fold desc="Methods">

  private

  #</editor-fold>

end
