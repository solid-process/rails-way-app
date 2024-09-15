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
  <tr><td><strong>Branch</strong></td><td>040-models-within-namespaces</td></tr>
  <tr><td><strong>Lines of Code</strong></td><td>1359</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.56</td></tr>
</table>

The previous versions already showed the benefits of organizing the codebase. This version goes further by grouping models within namespaces.

Beyond the code structure, check out the model's implementation to see how the associations reflect the namespace structure.

Here is the comparison of the models' directory structure (before and after):

<table>
  <tr>
    <th>Before</th>
    <th>After</th>
  </tr>
  <tr>
    <td>
      <pre>
app/models
├── account.rb
├── application_record.rb
├── current.rb
├── membership.rb
├── task_item.rb
├── task_list.rb
├── user.rb
└── user_token.rb</pre>
    </td>
    <td>
      <pre>
app/models
├── account.rb
├── application_record.rb
├── concerns
├── current.rb
├── membership.rb
├── task
│  ├── item.rb
│  └── list.rb
├── user
│  └── token.rb
└── user.rb</pre>
    </td>
  </tr>
</table>

### 🤔 Why this change matter? <!-- omit in toc -->

Cohesion + consistency = maintainability.

### 🔎 What the next version will have? <!-- omit in toc -->

Seven iterations have been since version `021-multi-controllers-per-entity_rest_actions_only`, but the Rubycritic score has remained the same (_**91.56**_).

But what was the reason?

The same controllers handle both the web application and the REST API. In other words, there needs to be more cohesion since each request format serves different purposes.

Because of this, the next version will perform this separation, and with this, it will be possible to determine whether or not this care in promoting cohesion will improve the quality score.

`Next version`: [050-separation-of-entry-points](https://github.com/solid-process/rails-way-app/tree/050-separation-of-entry-points?tab=readme-ov-file).

## 📣 Important info

To understand the project's context, I'd like you to please read the [main branch's README](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file).

Check out the:
1. [disclaimer](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-disclaimer) to understand the project's purpose.
2. [summary](https://github.com/solid-process/rails-way-app/tree/main?tab=readme-ov-file#-repository-branches) of all branches.
