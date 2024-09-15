json.status :error
json.message message
json.details(local_assigns.fetch(:details, {}))
