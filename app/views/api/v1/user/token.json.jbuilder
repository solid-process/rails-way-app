json.status :success
json.type :object
json.data do
  json.user_token @user.token.value
end
