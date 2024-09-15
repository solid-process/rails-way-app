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
  <tr><td><strong>Branch</strong></td><td>031-resources-within-namespaces_base-controllers</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1355</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.56</td></tr>
</table>

In the branch `021-multi-controllers-per-entity_rest_actions_only`, the `TaskItemsConcern` was introduced to share code among the task item controllers.

However, as with the previously introduced namespaces, this version introduces the concept of base controllers to replace the concern usage. This way, the controllers within a namespace can have specific (more cohesive) parent classes.

See below how the task controllers are organized:

```sh
app/controllers/task
├── items
│  ├── base_controller.rb
│  ├── complete_controller.rb
│  └── incomplete_controller.rb
└── items_controller.rb
```

```ruby
Task::ItemsController < Task::Items::BaseController
Task::Items::CompletedController < Task::Items::BaseController
Task::Items::IncompleteController < Task::Items::BaseController
```

### 🤔 What are the benefits of using base controllers? <!-- omit in toc -->

Since the previous version, we can see that the Rubycritic score has remained the same, which is positive given that the improvements in the structure do not complicate the existing implementation.

Although the score has not changed, we can see how this grouping reduces the effort to understand and find your way around the code. This also translates into increased cohesion, not at the class level but at the namespace level (groups of classes and modules).

### 🔎 What the next version will have? <!-- omit in toc -->

The cohesion ideas (organization and grouping guided to a specific purpose) will be applied to views and partials. Check out to see the benefits of this approach.

`Next version`: [032-resources-within-namespaces_partials-grouped-by-context](https://github.com/solid-process/rails-way-app/tree/032-resources-within-namespaces_partials-grouped-by-context?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
