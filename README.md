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
  <tr><td><strong>Branch</strong></td><td>070-orthogonal-models</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1613</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>95.81</td></tr>
</table>

**Orthogonality** is the ability to change one thing without any unseen effect on other thing.

What this branch does is to decouple the `User` from the `Account` context to make the codebase even more orthogonal.

See how the two contexts are now separated:

<table>
  <tr>
    <th>Account</th>
    <th>User</th>
  </tr>
  <tr>
    <td>
      <pre>
app/models
├── account
│  ├── member
│  │  ├── authorization.rb
│  │  └── entity.rb
│  ├── member.rb
│  ├── membership.rb
│  ├── owner
│  │  ├── creation.rb
│  │  └── deletion.rb
│  ├── task
│  │  ├── item.rb
│  │  └── list.rb
│  └── task.rb
└── account.rb</pre>
    </td>
    <td>
      <pre>
app/models
├── user
│  ├── account_deletion.rb
│  ├── password_resetting.rb
│  ├── registration.rb
│  ├── token
│  │  └── entity.rb
│  └── token.rb
└── user.rb</pre>
    </td>
  </tr>
</table>

### 🤔 Why this change matter? <!-- omit in toc -->

The `User` model is now more focused on the user's behavior, while the `Account` model is more focused on the account's behavior.

This separation reduces the changes of undesired side effects when changing one of the models. This also happened when the Web and REST API resources were separated.

Another thing to notice is Rubycritic score which increased from `95.77` to `95.81`, reflecting the high cohesion and low coupling of the codebase.

### 🔎 What the next version will have? <!-- omit in toc -->

That's all folks! There is no other branch. 😉

After all these iterations, I hope you can see the enormous difference that focusing on cohesion and coupling can make in a codebase and how a framework like Rails (which has influenced so many others) is flexible enough to accommodate all these different approaches.

Ruby and Rails rocks! 🤘😎

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
