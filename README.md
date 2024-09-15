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
  <tr><td><strong>Branch</strong></td><td>063-domain-model_user-operations</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1563</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>95.77</td></tr>
</table>

This version isolates some user operations into specialized POROs (1). The goal here is to reduce the model's complexity.

Here's how the models are organized:

```sh
app/models
├── user
│  ├── account_deletion.rb
│  ├── password_resetting.rb
│  ├── registration.rb
│  ├── token
│  │  └── entity.rb
│  └── token.rb
└── user.rb
```

*References:*
(1) https://dev.37signals.com/vanilla-rails-is-plenty/#what-about-services

### 🤔 Why this change matter? <!-- omit in toc -->

Can you imagine a model with hundreds of lines of code? It's hard to maintain, right? By isolating some operations into specialized POROs, we can reduce the complexity and make things easier to maintain.

Beyond this, did you see that the file and folder structure reveals the domain model and what kind of operations that context can do?

This approach can distribute the complexity over specialized classes and, as a side effect, increase the codebase's understandability.

### 🔎 What the next version will have? <!-- omit in toc -->

The next iteration will define the account context and decouple the user model from it to make the codebase even more orthogonal (orthogonality = the ability to change one thing without any unseen effect on other things).

`Next version`: [070-orthogonal-models](https://github.com/solid-process/rails-way-app/tree/070-orthogonal-models?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
