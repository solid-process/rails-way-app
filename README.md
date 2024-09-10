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
  <tr><td><strong>Branch</strong></td><td>011-one-controller-per-entity_user-concerns</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1350</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>90.34</td></tr>
</table>

**Refactoring with ActiveSupport::Concern:**

This is how this [feature is presented in the Rails Guides](https://guides.rubyonrails.org/getting_started.html#using-concerns):

> Concerns are a way to make large controllers or models easier to understand and manage. This also has the advantage of reusability when multiple models (or controllers) share the same concerns.

Since the user controller has the largest number of actions, this version makes use of ActiveSupport::Concern to separate the different responsibilities of this controller. Here's how the distribution between the files looks:

```sh
 21 app/controllers/users_controller.rb
 48 app/controllers/concerns/user_passwords_concern.rb
 41 app/controllers/concerns/user_profiles_concern.rb
 48 app/controllers/concerns/user_registrations_concern.rb
 49 app/controllers/concerns/user_sessions_concern.rb
 38 app/controllers/concerns/user_tokens_concern.rb
245 total
```

We can see a positive impact on the Rubycritic score, which went from `89.23` to `90.24`.

However, it is important to note that a concern is a mixin. That is, methods with the same name will be overridden. That is why each concern file needs to maintain the prefixes or suffixes in its methods (Examples: new_session, create_session, user_session_params...).

In this case, the use of mixins is just separating a large class into several smaller ones, but in the end, we end up having the same large class, but with its implementation in separate files.


### 🤔 Would it be possible to achieve this separation and avoid this collision? <!-- omit in toc -->

The answer is _**yes**_! 🙌

### 🔎 What the next version will have? <!-- omit in toc -->

It shows how to separate the concerns into different controllers. This way, we can have a better separation of responsibilities and avoid the collision of methods with the same name.

`Next version`: [020-multi-controllers-per-entity](https://github.com/solid-process/rails-way-app/tree/020-multi-controllers-per-entity?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
