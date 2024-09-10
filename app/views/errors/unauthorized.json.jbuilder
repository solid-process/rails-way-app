json.partial! "errors/response", locals: {
  message: local_assigns.fetch(:message, "Invalid API token")
}
