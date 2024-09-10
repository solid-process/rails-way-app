# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :account

  enum :role, { owner: "owner" }
end
