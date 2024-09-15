json.status :success
json.type :collection
json.data { json.array!(@task_lists, partial: "record", as: :task_list) }
json.url api_v1_task_lists_url(format: :json)
