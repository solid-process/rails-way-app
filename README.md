<small>

> `MENU` **README** | [How to run locally](./docs/00_INSTALLATION.md) | [REST API doc](./docs/01_REST_API_DOC.md) | [Web app screenshots](./docs/02_WEB_APP_SCREENSHOTS.md)

</small>

# 🚆 Rails Way App <!-- omit in toc -->

_**Eighteen versions**_ (gradually implemented) of a Web and REST API app made with [Ruby on Rails](https://guides.rubyonrails.org/) that aims to get the most out of the `MVC`/`Rails Way`.

## 📚 Table of contents <!-- omit in toc -->

- [💡 Summary](#-summary)
- [📣 Important info](#-important-info)

## 💡 Summary

<table>
  <tr><td><strong>Branch</strong></td><td>030-resources-within-namespaces</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1361</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.56</td></tr>
</table>

This version implements the ideas presented in this article https://jeromedalbert.com/how-dhh-organizes-his-rails-controllers/, and introduces the concept of `namespaces` to controllers and routes.

**Controllers:**

<table>
  <tr>
    <th>Before</th>
    <th>After</th>
  </tr>
  <tr>
    <td>
      <pre>
app/controllers
├── concerns
│  └── task_items_concern.rb
├── application_controller.rb
├── complete_task_items_controller.rb
├── incomplete_task_items_controller.rb
├── task_items_controller.rb
├── task_lists_controller.rb
├── user_passwords_controller.rb
├── user_profiles_controller.rb
├── user_registrations_controller.rb
├── user_sessions_controller.rb
└── user_tokens_controller.rb</pre>
    </td>
    <td>
      <pre>
app/controllers
├── concerns
│  └── task_items_concern.rb
├── application_controller.rb
├── task
│  ├── items
│  │  ├── complete_controller.rb
│  │  └── incomplete_controller.rb
│  ├── items_controller.rb
│  └── lists_controller.rb
└── user
   ├── passwords_controller.rb
   ├── profiles_controller.rb
   ├── registrations_controller.rb
   ├── sessions_controller.rb
   └── tokens_controller.rb</pre>
    </td>
  </tr>
</table>

**Routes**

<table>
  <tr>
    <th>Before</th>
    <th>After</th>
  </tr>
  <tr>
    <td>
      <pre>
/user_sessions
/user_sessions/new
/user_registrations
/user_registrations/new
/user_passwords
/user_passwords/new
/user_passwords/:id/edit
/user_passwords/:id
/user_profiles/edit
/user_profiles
/user_tokens/edit
/user_tokens
/task_lists/:task_list_id/task_items
/task_lists/:task_list_id/task_items/new
/task_lists/:task_list_id/task_items/:id/edit
/task_lists/:task_list_id/task_items/:id
/task_lists/:task_list_id/complete_task_items/:id
/task_lists/:task_list_id/incomplete_task_items/:id
/task_lists
/task_lists/new
/task_lists/:id/edit
/task_lists/:id</pre>
    </td>
    <td>
      <pre>
/user/sessions
/user/sessions/new
/user/registrations
/user/registrations/new
/user/passwords
/user/passwords/new
/user/passwords/:id/edit
/user/passwords/:id
/user/profiles/edit
/user/profiles
/user/tokens/edit
/user/tokens
/task/lists/:list_id/items
/task/lists/:list_id/items/new
/task/lists/:list_id/items/:id/edit
/task/lists/:list_id/items/:id
/task/lists/:list_id/items/complete/:id
/task/lists/:list_id/items/incomplete/:id
/task/lists
/task/lists/new
/task/lists/:id/edit
/task/lists/:id</pre>
    </td>
  </tr>
</table>

### 🤔 What was changed? <!-- omit in toc -->

As we can see, the controllers and routes are organized more structuredly. Each main context has its own namespace (`task`, `user`), and the controllers are organized within it.

It is worth noting that the improvement in semantics is reflected in the routes, making them simpler and more readable.

### 🔎 What the next version will have? <!-- omit in toc -->

Due to the improvement of the structure, the concept of base controllers will be introduced. In other words, controllers within a namespace can have specific (more cohesive) parent classes.

`Next version`: [031-resources-within-namespaces_base-controllers](https://github.com/solid-process/rails-way-app/tree/031-resources-within-namespaces_base-controllers?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
