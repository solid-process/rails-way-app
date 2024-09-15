json.status :success
json.type :object
json.data { json.partial!("api/v1/task/items/record", task_item: @task_item) }
json.url api_v1_task_list_item_url(@task_item.task_list_id, @task_item, format: :json)
