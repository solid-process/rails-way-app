# frozen_string_literal: true

module UUID
  REGEXP = /\A[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}\z/

  def self.generate
    SecureRandom.uuid
  end
end
