# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :user, :member

  delegate :task_list,
           :task_lists,
           :task_list_id,
           :task_items, to: :member, allow_nil: true

  def member? = member&.authorized?

  def member!(task_list_id:)
    self.member = Account::Member::Authorization.with(task_list_id:, uuid: user&.uuid)
  end

  def user? = user&.persisted?

  def user!(**input)
    self.user =
      case input
      in { uuid:, **nil } then User.find_by(uuid:)
      in { token:, **nil } then find_user_by_token(token)
      end
  end

  private

  def find_user_by_token(value)
    token = User::Token::Entity.parse(value)

    User.joins(:token).find_by(user_tokens: { checksum: token.checksum }) if token.valid?
  end
end
