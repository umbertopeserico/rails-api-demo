module RandomId
  extend ActiveSupport::Concern

  included do
    before_create :set_id, if: Proc.new { self.id.blank? }
  end

  module ClassMethods

  end

  private

  def set_id
    hex = ''
    loop do
      hex = SecureRandom.hex(4)
      break if self.class.where(id: hex).empty?
    end

    self.id = hex.upcase
  end
end