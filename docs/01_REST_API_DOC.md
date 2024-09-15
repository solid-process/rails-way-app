<small>

> `MENU` [README](../README.md) | [How to run locally](./00_INSTALLATION.md) | **REST API doc** | [Web app screenshots](./02_WEB_APP_SCREENSHOTS.md)

</small>

# 🚆 Rails Way App <!-- omit in toc -->

REST API documentation (cURL examples).

## 📚 Table of contents <!-- omit in toc -->

- [User](#user)
  - [Registration](#registration)
  - [Authentication](#authentication)
  - [Account deletion](#account-deletion)
  - [API token updating](#api-token-updating)
  - [Password updating](#password-updating)
  - [Password resetting - Link to change the password](#password-resetting---link-to-change-the-password)
  - [Password resetting - Change the password](#password-resetting---change-the-password)
- [Task List](#task-list)
  - [Listing](#listing)
  - [Creation](#creation)
  - [Updating](#updating)
  - [Deletion](#deletion)
- [Task](#task)
  - [Listing](#listing-1)
  - [Creation](#creation-1)
  - [Updating](#updating-1)
  - [Marking as incomplete](#marking-as-incomplete)
  - [Marking as completed](#marking-as-completed)
  - [Deletion](#deletion-1)

Set the following environment variables to use the examples below:

```bash
export API_HOST="http://localhost:3000"
export API_TOKEN="MY_USER_TOKEN"
```

You can get the `API_TOKEN` by:
1. Using the below `User / Registration` request.
2. or copying the `API token` from `Sign In >> Settings >> API token` page.

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

### User

#### Registration

```bash
curl -X POST "$API_HOST/user/registrations" \
  -H "Content-Type: application/json" \
  -d '{
    "user": {
      "email": "email@example.com",
      "password": "123123123",
      "password_confirmation": "123123123"
    }
  }'
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

#### Authentication

```bash
curl -X POST "$API_HOST/user/sessions" \
  -H "Content-Type: application/json" \
  -d '{
    "user": {
      "email": "email@example.com",
      "password": "123123123"
    }
  }'
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

#### Account deletion

```bash
curl -X DELETE "$API_HOST/user/registrations" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_TOKEN"
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

#### API token updating

```bash
curl -X PUT "$API_HOST/user/tokens" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_TOKEN"
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

#### Password updating

```bash
curl -X PUT "$API_HOST/user/profiles" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_TOKEN" \
  -d '{
    "user": {
      "current_password": "123123123",
      "password": "321321321",
      "password_confirmation": "321321321"
    }
  }'
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

#### Password resetting - Link to change the password

```bash
curl -X POST "$API_HOST/user/passwords" \
  -H "Content-Type: application/json" \
  -d '{"user": {"email": "email@example.com"}}'
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

#### Password resetting - Change the password

```bash
curl -X PUT "$API_HOST/user/passwords/TOKEN_RETRIEVED_BY_EMAIL" \
  -H "Content-Type: application/json" \
  -d '{
    "user": {
      "password": "123123123",
      "password_confirmation": "123123123"
    }
  }'
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

### Task List

#### Listing

```bash
curl -X GET "$API_HOST/task/lists" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_TOKEN"
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

#### Creation

```bash
curl -X POST "$API_HOST/task/lists" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_TOKEN" \
  -d '{"task_list": {"name": "My Task List"}}'
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

#### Updating

```bash
curl -X PUT "$API_HOST/task/lists/2" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_TOKEN" \
  -d '{"task_list": {"name": "My List"}}'
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

#### Deletion

```bash
curl -X DELETE "$API_HOST/task/lists/2" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_TOKEN"
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

### Task

#### Listing

```bash
# ?filter=completed | incomplete

curl -X GET "$API_HOST/task/lists/1/items" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_TOKEN"
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

#### Creation

```bash
curl -X POST "$API_HOST/task/lists/1/items" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_TOKEN" \
  -d '{"task_item": {"name": "My Task"}}'
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

#### Updating

```bash
# "completed": true | 1 | false | 0

curl -X PUT "$API_HOST/task/lists/1/items/1" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_TOKEN" \
  -d '{"task_item": {"name": "My Task", "completed": true}}'
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

#### Marking as incomplete

```bash
curl -X PUT "$API_HOST/task/lists/1/items/incomplete/1" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_TOKEN"
```

#### Marking as completed

```bash
curl -X PUT "$API_HOST/task/lists/1/items/complete/1" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_TOKEN"
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

#### Deletion

```bash
curl -X DELETE "$API_HOST/task/lists/1/items/1" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_TOKEN"
```

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>
