# == Schema Information
#
# Table name: v1_passengers
#
#  id              :string           not null, primary key
#  email           :string           not null
#  first_name      :string
#  last_name       :string
#  password_digest :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_v1_passengers_on_LOWER_email  (lower((email)::text)) UNIQUE
#

class V1::Passengers::Passenger < V1::ApplicationRecord
  #<editor-fold desc="Modules">
  self.table_name = V1::Passengers.table_name_prefix(no_last_underscore: true)
  include RandomId

  has_secure_password
  #</editor-fold>

  #<editor-fold desc="Relations">
  has_one :preferences,
          class_name: 'V1::Passengers::Preference',
          inverse_of: :passenger,
          dependent: :destroy
  accepts_nested_attributes_for :preferences

  has_many :reservations,
           class_name: 'V1::Flights::Reservations::Reservation',
           inverse_of: :owner,
           foreign_key: :owner_id
  #</editor-fold>

  #<editor-fold desc="Validations">
  validates :first_name,
            presence: true

  validates :last_name,
            presence: true

  validates :email,
            presence: true,
            uniqueness: {case_sensitive: false},
            email_format: {message: I18n.t('activerecord.errors.messages.invalid_email')}
  #</editor-fold>

  #<editor-fold desc="Callbacks">
  before_validation :downcase_email

  #</editor-fold>

  #<editor-fold desc="Methods">
  def to_s
    full_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def jwt_payload
    {
        id: self.id
    }
  end

  class << self
    def authenticate_by_email(params)
      user = self.find_by(email: params[:email])

      !!user && user.authenticate(params[:password])
    end

    def authenticate_by_token(token)
      payload = JsonWebToken.decode(token)

      !!payload && self.find_by(id: payload[:id])
    end
  end

  private

  def downcase_email
    self.email = self.email.to_s.downcase
  end

  #</editor-fold>

end
