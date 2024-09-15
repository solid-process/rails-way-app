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
  <tr><td><strong>Branch</strong></td><td>032-resources-within-namespaces_partials-grouped-by-context</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1355</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.56</td></tr>
</table>

The previous version revealed the benefits of group controller within namespaces. This version will apply the same ideas to the view partials.

Let's see comparation between the previous and current structure:

<table>
  <tr>
    <th>Previous</th>
    <th>Current</th>
  </tr>
  <tr>
    <td>
      <pre>
app/views
├── shared
│  ├── settings
│  │  └── _header.html.erb
│  ├── tasks
│  │  ├── _add_new.html.erb
│  │  └── _header.html.erb
│  └── users
│     ├── _header.html.erb
│     ├── _reset_password_link.html.erb
│     ├── _sign_in_link.html.erb
│     ├── _sign_up_link.html.erb
│     └── user_token.json.jbuilder
├── task
│  ├── items
│  │  ├── _delete_action.html.erb
│  │  ├── _edit_action.html.erb
│  │  ├── _toggle_status_action.html.erb
│  └── lists
│     ├── _delete_action.html.erb
│     ├── _edit_action.html.erb
│     ├── _view_items_action.html.erb</pre>
    </td>
    <td>
      <pre>
app/views
├── task
│  ├── items
│  │  ├── actions
│  │  │  ├── _delete.html.erb
│  │  │  ├── _edit.html.erb
│  │  │  └── _toggle_status.html.erb
│  ├── lists
│  │  ├── actions
│  │  │  ├── _delete.html.erb
│  │  │  ├── _edit.html.erb
│  │  │  └── _view_items.html.erb
│  └── shared
│     ├── _add_new.html.erb
│     └── _header.html.erb
├── user
│  ├── shared
│  │  ├── _header.html.erb
│  │  ├── links
│  │  │  ├── _reset_password.html.erb
│  │  │  ├── _sign_in.html.erb
│  │  │  └── _sign_up.html.erb
│  │  ├── settings
│  │  │  └── _header.html.erb</pre>
    </td>
  </tr>
</table>

### 🤔 Why is this structure more cohesive than the previous one? <!-- omit in toc -->

To answer this, let's analyze the partials in the app/views/shared folder from the previous version. It was less cohesive because it knew all the application contexts (settings, tasks, and users).

The current version shows that these partials have been moved to task or user contexts. This change created a more cohesive structure because of the lower indirection and greater specificity of each partial's use.

### 🔎 What the next version will have? <!-- omit in toc -->

Aiming increasing the cohesion of the application, the next version will move the mailer views under the entity user context.

`Next version`: [033-resources-within-namespaces_mailers-under-entity-context](https://github.com/solid-process/rails-way-app/tree/033-resources-within-namespaces_mailers-under-entity-context?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
