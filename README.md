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
  <tr><td><strong>Branch</strong></td><td>034-resources-within-namespaces_nested-namespaces</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1356</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.56</td></tr>
</table>

This version pushes the cohesion further by creating another nested namespace (`User::Settings`).

<table>
  <tr>
    <th>Before</th>
    <th>After</th>
  </tr>
  <tr>
    <td>
      <pre>
app/views/user
├── mailers/
├── passwords/
├── profiles/
├── registrations/
├── sessions/
├── shared
│  ├── links
│  └── settings
└── tokens
app/controllers/user
├── passwords_controller.rb
├── profiles_controller.rb
├── registrations_controller.rb
├── sessions_controller.rb
└── tokens_controller.rb</pre>
    </td>
    <td>
      <pre>
app/views/user
├── mailers/
├── passwords/
├── registrations/
├── sessions/
├── settings
│  ├── profiles/
│  └── tokens/
└── shared
   └── links/
app/controllers/user
├── passwords_controller.rb
├── registrations_controller.rb
├── sessions_controller.rb
└── settings
   ├── profiles_controller.rb
   └── tokens_controller.rb</pre>
    </td>
  </tr>
</table>

### 🤔 Why is this structure more cohesive than the previous one? <!-- omit in toc -->

Because all user settings resources are isolated in the same namespace (`User::Settings`), which makes it easier to maintain and understand the codebase.

### 🔎 What the next version will have? <!-- omit in toc -->

Aiming to improve the expressiveness of the application, the next version will make more use of singular resources.

`Next version`: [035-resources-within-namespaces_singular_resources](https://github.com/solid-process/rails-way-app/tree/035-resources-within-namespaces_singular_resources?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
