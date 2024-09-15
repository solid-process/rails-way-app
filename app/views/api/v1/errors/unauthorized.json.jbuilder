json.partial! "api/v1/errors/response", locals: {
  message: local_assigns.fetch(:message, "Invalid API token")
}
