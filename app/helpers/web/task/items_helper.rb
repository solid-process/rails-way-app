# frozen_string_literal: true

module Web::Task::ItemsHelper
  def task_lists_selector
    safe_join([
      tag.br,
      select_tag(
        "task_list",
        options_from_collection_for_select(Current.task_lists, "id", "name", Current.task_list_id),
        style: "width: 97%;",
        onchange: "Turbo.visit(`/task_lists/${this.value}/task_items`)"
      )
    ])
  end

  def link_to_task_item_filters
    style = "color: var(--text) !important;"

    all = { title: "All", path: task_list_items_path(Current.task_list_id), style: }
    completed = { title: "Completed", path: task_list_items_path(Current.task_list_id, filter: "completed"), style: }
    incomplete = { title: "Incomplete", path: task_list_items_path(Current.task_list_id, filter: "incomplete"), style: }

    case params[:filter]
    when "incomplete" then set_current_task_items_filter(incomplete)
    when "completed" then set_current_task_items_filter(completed)
    else set_current_task_items_filter(all)
    end

    safe_join([
      link_to(all[:title], all[:path], style: all[:style]),
      " | ",
      link_to(incomplete[:title], incomplete[:path], style: incomplete[:style]),
      " | ",
      link_to(completed[:title], completed[:path], style: completed[:style])
    ])
  end

  TASK_ITEMS_EMPTY_MESSAGES = {
    "all" => "You don't have any task items. Create one by touching the \"+ New item\" button.",
    "completed" => "You don't have any completed tasks. Keep up the good work!",
    "incomplete" => "You don't have any incomplete tasks. Great job!"
  }.freeze

  def empty_task_items_message(filter = nil)
    content_tag(:p, class: "notice", style: "color: var(--text); border: 2px solid var(--text); text-align: center;") do
      TASK_ITEMS_EMPTY_MESSAGES[filter] || TASK_ITEMS_EMPTY_MESSAGES["all"]
    end
  end

  private

  def set_current_task_items_filter(options)
    options.merge!(title: "#{options[:title]} (#{@task_items.size})", style: "")
  end
end
