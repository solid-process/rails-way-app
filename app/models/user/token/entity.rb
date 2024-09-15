# frozen_string_literal: true

class User::Token::Entity
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveSupport::Configurable

  SHORT_LENGTH = 8
  LONG_LENGTH = 32
  LONG_MASKED = "X" * LONG_LENGTH
  VALUE_SEPARATOR = "_"

  config_accessor :random, instance_writer: false, default: SecureRandom

  attribute :short, :string, default: -> { random.base58(SHORT_LENGTH) }
  attribute :long, :string, default: -> { random.base58(LONG_LENGTH) }

  validates :short, presence: true, length: { is: SHORT_LENGTH }
  validates :long, presence: true, length: { is: LONG_LENGTH }

  def self.parse(arg)
    short, long = arg.split(VALUE_SEPARATOR)

    new(short:, long:)
  end

  def checksum
    Digest::SHA256.hexdigest(secret)
  end

  def value
    "#{short}#{VALUE_SEPARATOR}#{long.presence || LONG_MASKED}"
  end

  private

  def secret
    salt1, salt2, salt3, salt4 = salt_parts

    "#{salt2}_#{salt3}.:#{long}:.#{salt4}-#{salt1}"
  end

  def salt_parts
    a, b, c, d, e, f, g, h = short.chars

    [ "#{h}#{c}", "#{e}#{g}", "#{b}#{d}", "#{f}#{a}" ]
  end
end
