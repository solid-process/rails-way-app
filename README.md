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
  <tr><td><strong>Branch</strong></td><td>050-separation-of-entry-points</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1462</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>94.04</td></tr>
</table>

This version shows a substantial increase in the Rubycritic score, from `91.56` to `94.04`. The reason for this growth was the separation between the Web and REST API controllers and routes. Before that, both formats were handled by a single controller.

This separation of concerns reflects how cohesive each of these contexts has become.

See how the controllers and views are now organized:

**Controllers**

<table>
  <tr>
    <th>Web</th>
    <th>API::V1</th>
  </tr>
  <tr>
    <td>
      <pre>
app/controllers/web
├── base_controller.rb
├── task
│  ├── items
│  │  ├── base_controller.rb
│  │  ├── complete_controller.rb
│  │  └── incomplete_controller.rb
│  ├── items_controller.rb
│  └── lists_controller.rb
└── user
   ├── passwords_controller.rb
   ├── registrations_controller.rb
   ├── sessions_controller.rb
   └── settings
      ├── profiles_controller.rb
      └── tokens_controller.rb</pre>
    </td>
    <td>
      <pre>
app/controllers/api
└── v1
   ├── base_controller.rb
   ├── task
   │  ├── items
   │  │  ├── base_controller.rb
   │  │  ├── complete_controller.rb
   │  │  └── incomplete_controller.rb
   │  ├── items_controller.rb
   │  └── lists_controller.rb
   └── user
      ├── passwords
      │  └── resettings_controller.rb
      ├── passwords_controller.rb
      ├── registrations_controller.rb
      ├── sessions_controller.rb
      └── tokens_controller.rb</pre>
    </td>
  </tr>
</table>

**Views**

<table>
  <tr>
    <th>Web</th>
    <th>API::V1</th>
  </tr>
  <tr>
    <td>
      <pre>
app/views/web
├── task
│  ├── items
│  │  ├── _form.html.erb
│  │  ├── actions
│  │  │  ├── _delete.html.erb
│  │  │  ├── _edit.html.erb
│  │  │  └── _toggle_status.html.erb
│  │  ├── edit.html.erb
│  │  ├── index.html.erb
│  │  ├── new.html.erb
│  │  └── show.html.erb
│  ├── lists
│  │  ├── _form.html.erb
│  │  ├── actions
│  │  │  ├── _delete.html.erb
│  │  │  ├── _edit.html.erb
│  │  │  └── _view_items.html.erb
│  │  ├── edit.html.erb
│  │  ├── index.html.erb
│  │  ├── new.html.erb
│  │  └── show.html.erb
│  └── shared
│     ├── _add_new.html.erb
│     └── _header.html.erb
└── user
   ├── passwords
   │  ├── edit.html.erb
   │  └── new.html.erb
   ├── registrations
   │  └── new.html.erb
   ├── sessions
   │  └── new.html.erb
   ├── settings
   │  ├── _header.html.erb
   │  ├── profiles
   │  │  └── edit.html.erb
   │  └── tokens
   │     └── edit.html.erb
   └── shared
      ├── _header.html.erb
      └── links
         ├── _reset_password.html.erb
         ├── _sign_in.html.erb
         └── _sign_up.html.erb</pre>
    </td>
    <td>
      <pre>
app/views/api
└── v1
   ├── errors
   │  ├── _response.json.jbuilder
   │  ├── from_model.json.jbuilder
   │  ├── response.json.jbuilder
   │  └── unauthorized.json.jbuilder
   ├── task
   │  ├── items
   │  │  ├── _record.json.jbuilder
   │  │  ├── index.json.jbuilder
   │  │  └── show.json.jbuilder
   │  └── lists
   │     ├── _record.json.jbuilder
   │     ├── index.json.jbuilder
   │     └── show.json.jbuilder
   └── user
      └── token.json.jbuilder</pre>
    </td>
  </tr>
</table>

### 🤔 Why this change matter? <!-- omit in toc -->

In addition to the increased cohesion, we can also see each context has the freedom to represent and organize its resources semantically.

For example, the web application uses the profile to update passwords. When we look at this resource, we see `web/user/settings/profiles`. However, the same responsibility was reflected differently in the API: `api/v1/user/passwords`.

_**This was unfeasible with the previous approach!**_

### 🔎 What the next version will have? <!-- omit in toc -->

Apart from adding namespaces, the implementation of models has stayed the same so far.

Although this version improved the Rubycritic score significantly, it introduced duplication in controllers.

The next version will remove this duplication by concentrating logic in models.

`Next version`: [051-separation-of-entry-points_fat-models](https://github.com/solid-process/rails-way-app/tree/051-separation-of-entry-points_fat-models?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
