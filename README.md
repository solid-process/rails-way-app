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
  <tr><td><strong>Branch</strong></td><td>010-one-controller-per-entity</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1326</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>89.23</td></tr>
</table>

In this version, a single controller is used for each main entity of the system (model).

This approach is quite common, given that the scaffold generator (presented in almost every Rails tutorial) creates a controller for each model. Based on this premise, it is intuitive to keep a single controller per model and add new actions if necessary.

As a side effect, the user controller contains the largest number of actions (Registration, Authentication, Account Deletion, API Token Refresh, Password Update, and Password Reset). Since it handles different operations, it is less cohesive than the others.

```sh
110 app/controllers/application_controller.rb
130 app/controllers/task_items_controller.rb
82  app/controllers/task_lists_controller.rb
206 app/controllers/users_controller.rb
528 total
```

### 🤔 What is the problem with low cohesion code?  <!-- omit in toc -->

Low cohesion leads to greater coupling, higher costs, and efforts to promote changes.

### 🔎 What the next version will have? <!-- omit in toc -->

It will address the low cohesion of the user controller by extracting concerns into separate modules. This way, each concern will be responsible for specific actions, making the code more cohesive.

`Next version:` [011-one-controller-per-entity_user-concerns](https://github.com/solid-process/rails-way-app/tree/011-one-controller-per-entity_user-concerns?tab=readme-ov-file)

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
