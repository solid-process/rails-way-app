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
  <tr><td><strong>Branch</strong></td><td>051-separation-of-entry-points_fat-models</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1456</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>95.56</td></tr>
</table>

This version increases the Rubycritic score from `94.04` to `95.56` by moving the existing duplications to the models, the famous fat models and skinny controllers.

### 🤔 Why this change matter? <!-- omit in toc -->

Because eliminating duplication generally increases maintenance.

_**But be careful:**_ excessive and indiscriminate use of DRY (Don't Repeat Yourself) can compromise understanding and maintenance.

Try to create abstractions only to address real needs (real problems).

### 🔎 What the next version will have? <!-- omit in toc -->

In the next version, we will enrich the application's domain model, starting with the Current class, which contains different responsibilities and a higher level of complexity.

`Next version`: [060-domain-model_account-member-poro](https://github.com/solid-process/rails-way-app/tree/060-domain-model_account-member-poro?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
