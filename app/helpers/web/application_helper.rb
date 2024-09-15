# frozen_string_literal: true

module Web::ApplicationHelper
  def current_nav_item?(input)
    "current" if current_resource?(input)
  end

  def current_resource?(input)
    case input
    in { action:, **nil } then current_resource_match?(action_name, action)
    in { controller:, **nil } then current_resource_match?(controller_name, controller)
    in { controller:, action: } then current_resource?(controller:) && current_resource?(action:)
    end
  end

  def current_resource_match?(value, pattern)
    case pattern
    in { not: ptn } then !current_resource_match?(value, ptn)
    in String | Regexp then value.match?(pattern)
    end
  end
end
