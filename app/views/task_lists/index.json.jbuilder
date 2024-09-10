json.status :success
json.type :collection
json.data { json.array!(@task_lists, partial: "task_lists/task_list", as: :task_list) }
json.url task_lists_url(format: :json)
