json.status :success
json.type :object
json.data do
  json.user_token @user.user_token.value
end
