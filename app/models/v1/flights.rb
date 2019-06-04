module V1::Flights
  def self.table_name_prefix(no_last_underscore: false)
    V1.table_name_prefix + 'flights' + (no_last_underscore ? '' : '_')
  end
end
