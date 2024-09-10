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
  <tr><td><strong>Branch</strong></td><td>020-multi-controllers-per-entity</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1342</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.34</td></tr>
</table>

The previous version demonstrates how concerns can help safely move code around, facilitating a better understanding of the different responsibilities in an implementation.

These were the created concerns:
- `UserRegistrationsConcern`
- `UserSessionsConcern`
- `UserPasswordsConcern`
- `UserTokensConcern`
- `UserProfilesConcern`

However, since the concerns are mixins, we need to ensure that all method names are unique. After all, if any are repeated, they will overwrite each other.

And here is what this version does. It uses the concerns categorization to implement dedicated routes and controllers.

See how the controllers turned out:

```sh
110 app/controllers/application_controller.rb
130 app/controllers/task_items_controller.rb
 82 app/controllers/task_lists_controller.rb
 60 app/controllers/user_passwords_controller.rb
 41 app/controllers/user_profiles_controller.rb
 49 app/controllers/user_registrations_controller.rb
 50 app/controllers/user_sessions_controller.rb
 25 app/controllers/user_tokens_controller.rb
547 total
```

### 🤔 What was changed? <!-- omit in toc -->

The Rubycritic score increased from `90.34` to `91.34`.

This happened because each controller allowed the isolation of each action and callback and allowed the definition of methods with the same name. (Example: `user_params` instead of `user_registration_params`, `user_session_params`, `user_password_params`...).

Another benefit was the routing definition. It became more readable and easier to understand as it was possible to declare them using only default `REST` actions (index, show, new, create, edit, update, destroy).

### 🔎 What the next version will have? <!-- omit in toc -->

It shows how the restriction of REST actions can enforce cohesion and ensure controllers are responsible for specific contexts/concepts.

`Next version`: [021-multi-controllers-per-entity_rest-actions-only](https://github.com/solid-process/rails-way-app/tree/021-multi-controllers-per-entity_rest-actions-only?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
