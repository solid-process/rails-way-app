json.status :success
json.type :collection
json.data { json.array!(@task_items, partial: "record", as: :task_item) }
json.url api_v1_task_list_items_url(Current.task_list_id, format: :json)
