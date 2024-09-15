json.status :success
json.type :object
json.data { json.partial!("task/lists/task_list", task_list: @task_list) }
json.url task_list_url(@task_list, format: :json)
