json.partial! "api/v1/errors/response", locals: {
  message: model.errors.full_messages.join(", "),
  details: model.errors.messages
}
