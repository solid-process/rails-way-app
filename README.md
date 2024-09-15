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
  <tr><td><strong>Branch</strong></td><td>062-domain-model_task-constants</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1526</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>95.78</td></tr>
</table>

This branch continues to enrich the domain model with a simple change. It ensures that the strings "completed" and "incomplete" are transformed into constants, `Task::COMPLETED` and `Task::INCOMPLETE`.

Note that this change also increases the Rubycritic score from `95.68` to `95.78`.

### 🤔 Why this change matter? <!-- omit in toc -->

> Coupling is good when it is stable.

Before this change, breaking the behavior by committing a typo anywhere coupled to these strings would be possible. Now, using constants, we have a single reference for all usage points in the

### 🔎 What the next version will have? <!-- omit in toc -->

The next iteration will extract complex operations from the models into specialized POROs.

`Next version`: [063-domain-model_user-operations](https://github.com/solid-process/rails-way-app/tree/063-domain-model_user-operations?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
