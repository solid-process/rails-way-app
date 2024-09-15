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
  <tr><td><strong>Branch</strong></td><td>061-domain-model_user-token-poro</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1519</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>95.68</td></tr>
</table>

This branch introduces a **PORO** (Plain Old Ruby Objects) to handle the user token parsing, generation, and validation.

But wait, is this a good practice? Yes, it is. Extracting complex logic from `ActiveRecord` models is a common pattern. It is a recommendation present in the Rails documentation since version 3.1.0 ([released in 2011](https://github.com/rails/rails/tree/v3.1.0)).

> The _**Model layer**_ represents the domain model (such as Account, Product, Person, Post, etc.) and encapsulates the business logic specific to your application. In Rails, database-backed model classes are derived from `ActiveRecord::Base`. Active Record allows you to present the data from database rows as objects and embellish these data objects with business logic methods.
>
> Although most Rails models are backed by a database, _**models can also be ordinary Ruby classes, or Ruby classes that implement a set of interfaces as provided by the Active Model module**_.

Let me emphasize this part:

> Models can also be ordinary Ruby classes, or Ruby classes that implement a set of interfaces as provided by
the Active Model module.

### 🤔 Why this change matter? <!-- omit in toc -->

This change matters because it's a good practice to extract complex logic from `ActiveRecord` models. As a result, the Rubycritc score increased again, from `95.63` to `95.68`.

### 🔎 What the next version will have? <!-- omit in toc -->

The next version will isolate some strings into constants to reduce codebase duplication and fragility (weak references).

`Next version`: [062-domain-model_task-constants](https://github.com/solid-process/rails-way-app/tree/062-domain-model_task-constants?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
