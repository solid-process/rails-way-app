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
  <tr><td><strong>Branch</strong></td><td>021-multi-controllers-per-entity_rest-actions-only</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1361</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.56</td></tr>
</table>

This version ensures that all controllers only have REST actions.

To accomplish this the `task_items#complete` and `task_items#incomplete` actions were moved to their own controller:

| From                             | To                                     |
| -------------------------------- | -------------------------------------- |
| `TaskItemsComtroller#complete`   | `CompleteTaskItemsController#update`   |
| `TaskItemsComtroller#incomplete` | `IncompleteTaskItemsController#update` |

Beyond this change, concern was created to share code between the `CompleteTaskItemsController,` `IncompleteTaskItemsController`, and `TaskItemsController.`

See how the task items controllers are now:

```sh
app/controllers/
├──  concerns/
│  └── task_items_concern.rb
├── complete_task_items_controller.rb
├── incomplete_task_items_controller.rb
└── task_items_controller.rb
```

### 🤔 What was changed? <!-- omit in toc -->

The Rubycritic score increased from `91.34` to `91.56`.

This happened because each cohesion has been increased, and the controllers are more specialized.

But lets be honest, the routes are worse than before. 😅

### 🔎 What the next version will have? <!-- omit in toc -->

Let's do what DHH taught us over a decade ago: https://jeromedalbert.com/how-dhh-organizes-his-rails-controllers/

This will improve the routes and put the controllers in a better structure.

`Next version`: [030-resources-within-namespaces](https://github.com/solid-process/rails-way-app/tree/030-resources-within-namespaces?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
