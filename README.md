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
  <tr><td><strong>Branch</strong></td><td>033-resources-within-namespaces_mailers-under-entity-context</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1356</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.56</td></tr>
</table>

This version continues system cohesion improvement by moving user mailer views from app/views/user_mailers to app/views/user/mailers.

```sh
app/views/user
├── mailers
│  ├── email_confirmation.html.erb
│  ├── email_confirmation.text.erb
│  ├── reset_password.html.erb
│  └── reset_password.text.erb
├── passwords/
├── profiles/
├── registrations/
├── sessions/
├── shared/
└── tokens/
```

### 🤔 Why is this structure more cohesive than the previous one? <!-- omit in toc -->

Because the mailer views are now located under the user entity context.

### 🔎 What the next version will have? <!-- omit in toc -->

Aiming to increase cohesion, the next version will add another nested namespace to isolate all user settings resources.

`Next version`: [034-resources-within-namespaces_nested-namespaces](https://github.com/solid-process/rails-way-app/tree/034-resources-within-namespaces_nested-namespaces?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
