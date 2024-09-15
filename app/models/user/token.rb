# frozen_string_literal: true

class User::Token < ApplicationRecord
  self.table_name = "user_tokens"

  belongs_to :user

  attribute :long, :string

  before_validation :refresh, on: :create

  validate { _1.errors.import(_1.entity.errors) if _1.entity.invalid? }

  def entity
    Entity.new(short:, long:)
  end

  def value
    entity.value
  end

  def refresh
    short, long, checksum = Entity.new.values_at(:short, :long, :checksum)

    assign_attributes(short:, long:, checksum:)
  end

  def refresh!(...)
    attempts ||= 1

    refresh(...).then { save! }.then { self }
  rescue ActiveRecord::RecordNotUnique
    retry if (attempts += 1) <= 3
  end
end
