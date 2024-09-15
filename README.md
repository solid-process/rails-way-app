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
  <tr><td><strong>Branch</strong></td><td>035-resources-within-namespaces_singular_resources</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1356</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.56</td></tr>
</table>

The definition of resources in the singular has been present since the first version (`010`).

What this branch does is make the declaration of resources consistent.

<table>
  <tr>
    <td><strong>Previous</strong></td>
    <td>
      <pre>
           Prefix Verb   URI Pattern                  Controller#Action
     user_session DELETE /user/session(.:format)      user/sessions#destroy
user_registration DELETE /user/registration(.:format) user/registrations#destroy</pre>
    </td>
  </tr>
  <tr>
    <td><strong>Current</strong></td>
    <td>
      <pre>
            Prefix Verb   URI Pattern                   Controller#Action
     user_sessions DELETE /user/sessions(.:format)      user/sessions#destroy
user_registrations DELETE /user/registrations(.:format) user/registrations#destroy</pre>
    </td>
  </tr>
</table>

### 🤔 Why does consistency matter? <!-- omit in toc -->

> Conceptual Integrity:
> In 1975, FredBrooks said: I will contend that Conceptual Integrity is the most important consideration in system design. It _**is better**_ to have a system omit certain anomalous features and improvements, but to reflect one set of design ideas, _**than**_ to have one that contains many good but independent and uncoordinated ideas.

Consistency is a key factor in the maintainability of a system. It makes it easier to understand and as a consequence, easier to maintain (promote changes).

This is applicable to everything in the system, from the code to the user interface.

This applies to everything in the system, from the code to the user interface. This branch was added to add this concept to the spotlight.

### 🔎 What the next version will have? <!-- omit in toc -->

Aiming to improve the application consistency, the following version groups some models within namespaces.

`Next version`: [040-models-within-namespaces](https://github.com/solid-process/rails-way-app/tree/040-models-within-namespaces?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
