module V1::Passengers
  def self.table_name_prefix(no_last_underscore: false)
    V1.table_name_prefix + 'passengers' + (no_last_underscore ? '' : '_')
  end
end
