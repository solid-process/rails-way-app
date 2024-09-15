json.status :success
json.type :object
json.data { json.partial!("api/v1/task/lists/record", task_list: @task_list) }
json.url api_v1_task_list_url(@task_list, format: :json)
