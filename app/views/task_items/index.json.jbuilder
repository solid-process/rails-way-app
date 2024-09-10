json.status :success
json.type :collection
json.data { json.array!(@task_items, partial: "task_items/task_item", as: :task_item) }
json.url task_list_task_items_url(Current.task_list_id, format: :json)
