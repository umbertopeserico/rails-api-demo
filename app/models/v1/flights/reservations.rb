module V1::Flights::Reservations
  def self.table_name_prefix(no_last_underscore: false)
    V1::Flights.table_name_prefix + 'reservations' + (no_last_underscore ? '' : '_')
  end
end
