<small>

> `MENU` **README** | [How to run locally](./docs/00_INSTALLATION.md) | [REST API doc](./docs/01_REST_API_DOC.md) | [Web app screenshots](./docs/02_WEB_APP_SCREENSHOTS.md) | [Branch descriptions](./docs/03_BRANCH_DESCRIPTIONS.md)

</small>

# 🚆 Rails Way App <!-- omit in toc -->

_**Eighteen versions**_ (gradually implemented) of a Web and REST API app made with [Ruby on Rails](https://guides.rubyonrails.org/) that aims to get the most out of the `MVC`/`Rails Way`.

## 📚 Table of contents <!-- omit in toc -->

- [📢 Disclaimer](#-disclaimer)
- [🙌 Repository branches](#-repository-branches)
- [👋 About](#-about)

## 📢 Disclaimer

[Ruby on Rails](https://rubyonrails.org/) is a highly productive MVC framework whose [primary value proposition is to be a one-person framework](https://www.youtube.com/watch?v=iqXjGiQ_D-A). In other words, to empower and make individuals as productive as entire teams.

However, this proposal applies not only to individuals but also to giant teams. [Shopify](https://shopify.engineering/), for example, has thousands of developers working on a monolithic and modular application with millions of lines of code.

**The main challenge of any medium to colossal system is to accommodate its complexity well**. As the code grows, we need to have the freedom and capacity to separate responsibilities in the best possible way.

The project's main objective is to demonstrate different approaches to improving the design of a Rails application without compromising its conventions and structure.

It is a `Web` and `REST API` app with over `4,000` lines of code (implementation + tests) and was implemented in **18 versions**. This is to gradually demonstrate the pros and cons of each approach. Enjoy! ✌️😊

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

## 🙌 Repository branches

This repository has **eighteen** branches that represent the application's evolution.

Every branch contains a `README.md` which explains the changes made in the codebase. However, you can access the documentation of all branches in the [`docs/03_BRANCH_DESCRIPTIONS.md`](./docs/03_BRANCH_DESCRIPTIONS.md) file.

| LOC / GRADE  | Branch |
| ------------ | ------ |
| 1326 / 89.23 | [010-one-controller-per-entity](https://github.com/solid-process/rails-way-app/blob/010-one-controller-per-entity?tab=readme-ov-file#-rails-way-app-) |
| 1350 / 90.34 | [011-one-controller-per-entity_user-concerns](https://github.com/solid-process/rails-way-app/blob/011-one-controller-per-entity_user-concerns?tab=readme-ov-file#-rails-way-app-) |
| 1342 / 91.34 | [020-multi-controllers-per-entity](https://github.com/solid-process/rails-way-app/blob/020-multi-controllers-per-entity?tab=readme-ov-file#-rails-way-app-) |
| 1361 / 91.56 | [021-multi-controllers-per-entity_rest-actions-only](https://github.com/solid-process/rails-way-app/blob/021-multi-controllers-per-entity_rest-actions-only?tab=readme-ov-file#-rails-way-app-) |
| 1361 / 91.56 | [030-resources-within-namespaces](https://github.com/solid-process/rails-way-app/blob/030-resources-within-namespaces?tab=readme-ov-file#-rails-way-app-) |
| 1355 / 91.56 | [031-resources-within-namespaces_base-controllers](https://github.com/solid-process/rails-way-app/blob/031-resources-within-namespaces_base-controllers?tab=readme-ov-file#-rails-way-app-) |
| 1355 / 91.56 | [032-resources-within-namespaces_partials-grouped-by-context](https://github.com/solid-process/rails-way-app/blob/032-resources-within-namespaces_partials-grouped-by-context?tab=readme-ov-file#-rails-way-app-) |
| 1356 / 91.56 | [033-resources-within-namespaces_mailers-under-entity-context](https://github.com/solid-process/rails-way-app/blob/033-resources-within-namespaces_mailers-under-entity-context?tab=readme-ov-file#-rails-way-app-) |
| 1356 / 91.56 | [034-resources-within-namespaces_nested-namespaces](https://github.com/solid-process/rails-way-app/blob/034-resources-within-namespaces_nested-namespaces?tab=readme-ov-file#-rails-way-app-) |
| 1356 / 91.56 | [035-resources-within-namespaces_singular_resources](https://github.com/solid-process/rails-way-app/blob/035-resources-within-namespaces_singular_resources?tab=readme-ov-file#-rails-way-app-) |
| 1359 / 91.56 | [040-models-within-namespaces](https://github.com/solid-process/rails-way-app/blob/040-models-within-namespaces?tab=readme-ov-file#-rails-way-app-) |
| 1462 / 94.04 | [050-separation-of-entry-points](https://github.com/solid-process/rails-way-app/blob/050-separation-of-entry-points?tab=readme-ov-file#-rails-way-app-) |
| 1456 / 95.56 | [051-separation-of-entry-points_fat-models](https://github.com/solid-process/rails-way-app/blob/051-separation-of-entry-points_fat-models?tab=readme-ov-file#-rails-way-app-) |
| 1504 / 95.63 | [060-domain-model_account-member-poro](https://github.com/solid-process/rails-way-app/blob/060-domain-model_account-member-poro?tab=readme-ov-file#-rails-way-app-) |
| 1519 / 95.68 | [061-domain-model_user-token-poro](https://github.com/solid-process/rails-way-app/blob/061-domain-model_user-token-poro?tab=readme-ov-file#-rails-way-app-) |
| 1526 / 95.78 | [062-domain-model_task-constants](https://github.com/solid-process/rails-way-app/blob/062-domain-model_task-constants?tab=readme-ov-file#-rails-way-app-) |
| 1563 / 95.77 | [063-domain-model_user-operations](https://github.com/solid-process/rails-way-app/blob/063-domain-model_user-operations?tab=readme-ov-file#-rails-way-app-) |
| 1613 / 95.81 | [070-orthogonal-models](https://github.com/solid-process/rails-way-app/blob/070-orthogonal-models?tab=readme-ov-file#-rails-way-app-) |

The following commands were used to generate the LOC and GRADE reports:
- **LOC** (lines of code): `bin/rails stats`
- **GRADE** (code quality): `bin/rails rubycritic`

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

## 👋 About

[Rodrigo Serradura](https://rodrigoserradura.com/) created this project. He is the creator of Solid Process, among other similar projects, such as [solid-rails-app](https://github.com/solid-process/solid-rails-app), which consists of demonstrating (in `12 gradual versions`) how the implementation of processes as code (based on the concept of use cases) can add value to a Ruby and Rails codebase.

In the Rails community, we have people at different stages of their careers and companies in various phases (validating ideas, refining, scaling products); the goal here is to help them on their journey. By sharing knowledge and practical references.

Ruby and the Rails framework is excellent, and my mission here is to try to add value to such great tools (Ruby and Rails rocks!!! 🤘😎).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>
