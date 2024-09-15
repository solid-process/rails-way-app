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
  <tr><td><strong>Branch</strong></td><td>060-domain-model_account-member-poro</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1504</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>95.63</td></tr>
</table>

The `Current` class had two responsibilities: containing thread-safe shared state and queries to authorize user access.

This branch separates these responsibilities, keeping the primary scope of the `Current` class (containing thread-safe and shareable state) but moving the authorization responsibility to the `Account::Member` and `Account::Member::Authorization` POROS (Plain Old Ruby Objects).

POROS means a model that doesn't inherit from `ActiveRecord`, and it's a common pattern to extract complex logic from `ActiveRecord` models.

### 🤔 Why this change matter? <!-- omit in toc -->

Cohesion + Separation of Concerns = Better understanding, maintainability and testability.

### 🔎 What the next version will have? <!-- omit in toc -->

In the next version, we will enrich the application's domain model, starting with the Current class, which contains different responsibilities and a higher level of complexity.

`Next version`: [061-domain-model_user-token-poro](https://github.com/solid-process/rails-way-app/tree/061-domain-model_user-token-poro?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
