# frozen_string_literal: true

class Account
  class Membership < ApplicationRecord
    self.table_name = "memberships"

    belongs_to :member
    belongs_to :account

    enum :role, { owner: "owner" }
  end
end
