# frozen_string_literal: true

class User::Token < ApplicationRecord
  self.table_name = "user_tokens"

  SHORT_LENGTH = 8
  LONG_LENGTH = 32
  LONG_MASKED = "X" * LONG_LENGTH
  VALUE_SEPARATOR = "_"

  belongs_to :user

  attribute :long, :string

  before_validation :refresh, on: :create

  validates :long, presence: true, length: { is: LONG_LENGTH }
  validates :short, presence: true, length: { is: SHORT_LENGTH }

  def self.parse_value(arg)
    arg.split(VALUE_SEPARATOR)
  end

  def self.salt_parts(short:)
    a, b, c, d, e, f, g, h = short.chars

    [ "#{h}#{c}", "#{e}#{g}", "#{b}#{d}", "#{f}#{a}" ]
  end

  def self.secret_value(short:, long:)
    salt1, salt2, salt3, salt4 = salt_parts(short:)

    "#{salt2}_#{salt3}.:#{long}:.#{salt4}-#{salt1}"
  end

  def self.checksum(...)
    Digest::SHA256.hexdigest(secret_value(...))
  end

  def value
    "#{short}#{VALUE_SEPARATOR}#{long || LONG_MASKED}"
  end

  def refresh(secure_random: SecureRandom)
    self.short = secure_random.base58(SHORT_LENGTH)
    self.long = secure_random.base58(LONG_LENGTH)
    self.checksum = self.class.checksum(short:, long:)
  end

  def refresh!(...)
    attempts ||= 1

    refresh(...).then { save! }.then { self }
  rescue ActiveRecord::RecordNotUnique
    retry if (attempts += 1) <= 3
  end
end
