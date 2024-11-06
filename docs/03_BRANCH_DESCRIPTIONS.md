<small>

> `MENU` [README](../README.md) | [How to run locally](./00_INSTALLATION.md) | [REST API doc](./01_REST_API_DOC.md) | [Web app screenshots](./02_WEB_APP_SCREENSHOTS.md) | Branch descriptions

</small>

# 🚆 Rails Way App <!-- omit in toc -->

This document presents the branches of the Rails Way App project.

## 📚 Table of contents <!-- omit in toc -->
- [010-one-controller-per-entity](#010-one-controller-per-entity)
- [011-one-controller-per-entity\_user-concerns](#011-one-controller-per-entity_user-concerns)
- [020-multi-controllers-per-entity](#020-multi-controllers-per-entity)
- [021-multi-controllers-per-entity\_rest-actions-only](#021-multi-controllers-per-entity_rest-actions-only)
- [030-resources-within-namespaces](#030-resources-within-namespaces)
- [031-resources-within-namespaces\_base-controllers](#031-resources-within-namespaces_base-controllers)
- [032-resources-within-namespaces\_partials-grouped-by-context](#032-resources-within-namespaces_partials-grouped-by-context)
- [033-resources-within-namespaces\_mailers-under-entity-context](#033-resources-within-namespaces_mailers-under-entity-context)
- [034-resources-within-namespaces\_nested-namespaces](#034-resources-within-namespaces_nested-namespaces)
- [035-resources-within-namespaces\_singular\_resources](#035-resources-within-namespaces_singular_resources)
- [040-models-within-namespaces](#040-models-within-namespaces)
- [050-separation-of-entry-points](#050-separation-of-entry-points)
- [051-separation-of-entry-points\_fat-models](#051-separation-of-entry-points_fat-models)
- [060-domain-model\_account-member-poro](#060-domain-model_account-member-poro)
- [061-domain-model\_user-token-poro](#061-domain-model_user-token-poro)
- [062-domain-model\_task-constants](#062-domain-model_task-constants)
- [063-domain-model\_user-operations](#063-domain-model_user-operations)
- [070-orthogonal-models](#070-orthogonal-models)

---

### 010-one-controller-per-entity

<table>
  <tr><td><strong>Lines of Code</strong></td><td>1326</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>89.23</td></tr>
</table>

In this version, a single controller is used for each main entity of the system (model).

This approach is quite common, given that the scaffold generator (presented in almost every Rails tutorial) creates a controller for each model. Based on this premise, it is intuitive to keep a single controller per model and add new actions if necessary.

As a side effect, the user controller contains the largest number of actions (Registration, Authentication, Account Deletion, API Token Refresh, Password Update, and Password Reset). Since it handles different operations, it is less cohesive than the others.

```sh
110 app/controllers/application_controller.rb
130 app/controllers/task_items_controller.rb
82  app/controllers/task_lists_controller.rb
206 app/controllers/users_controller.rb
528 total
```

#### 🤔 What is the problem with low-cohesion code?  <!-- omit in toc -->

Low cohesion leads to greater coupling, higher costs, and efforts to promote changes.

#### 🔎 What will the next version have? <!-- omit in toc -->

It will address the low cohesion of the user controller by extracting concerns into separate modules. This way, each concern will be responsible for specific actions, making the code more cohesive.

`Next version:` [011-one-controller-per-entity_user-concerns](https://github.com/solid-process/rails-way-app/tree/011-one-controller-per-entity_user-concerns?tab=readme-ov-file)

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 011-one-controller-per-entity_user-concerns

<table>
  <tr><td><strong>Lines of Code</strong></td><td>1350</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>90.34</td></tr>
</table>

**Refactoring with ActiveSupport::Concern:**

This is how this [feature is presented in the Rails Guides](https://guides.rubyonrails.org/getting_started.html#using-concerns):

> Concerns are a way to make large controllers or models easier to understand and manage. This also has the advantage of reusability when multiple models (or controllers) share the same concerns.

Since the user controller has the largest number of actions, this version makes use of ActiveSupport::Concern to separate the different responsibilities of this controller. Here's how the distribution between the files looks:

```sh
 21 app/controllers/users_controller.rb
 48 app/controllers/concerns/user_passwords_concern.rb
 41 app/controllers/concerns/user_profiles_concern.rb
 48 app/controllers/concerns/user_registrations_concern.rb
 49 app/controllers/concerns/user_sessions_concern.rb
 38 app/controllers/concerns/user_tokens_concern.rb
245 total
```

We can see a positive impact on the Rubycritic score, which went from `89.23` to `90.24`.

However, it is important to note that a concern is a mixin. That is, methods with the same name will be overridden. That is why each concern file needs to maintain the prefixes or suffixes in its methods (Examples: new_session, create_session, user_session_params...).

In this case, the use of mixins is just separating a large class into several smaller ones, but in the end, we end up having the same large class, but with its implementation in separate files.

#### 🤔 Would it be possible to achieve this separation and avoid this collision? <!-- omit in toc -->

The answer is _**yes**_! 🙌

#### 🔎 What will the next version have? <!-- omit in toc -->

It shows how to separate the concerns into different controllers. This way, we can have a better separation of responsibilities and avoid the collision of methods with the same name.

`Next version`: [020-multi-controllers-per-entity](https://github.com/solid-process/rails-way-app/tree/020-multi-controllers-per-entity?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 020-multi-controllers-per-entity

<table>
  <tr><td><strong>Lines of Code</strong></td><td>1342</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.34</td></tr>
</table>

The previous version demonstrates how concerns can help safely move code around, facilitating a better understanding of the different responsibilities in an implementation.

These were the created concerns:
- `UserRegistrationsConcern`
- `UserSessionsConcern`
- `UserPasswordsConcern`
- `UserTokensConcern`
- `UserProfilesConcern`

However, since the concerns are mixins, we need to ensure that all method names are unique. After all, if any are repeated, they will overwrite each other.

And here is what this version does. It uses the concerns categorization to implement dedicated routes and controllers.

See how the controllers turned out:

```sh
110 app/controllers/application_controller.rb
130 app/controllers/task_items_controller.rb
 82 app/controllers/task_lists_controller.rb
 60 app/controllers/user_passwords_controller.rb
 41 app/controllers/user_profiles_controller.rb
 49 app/controllers/user_registrations_controller.rb
 50 app/controllers/user_sessions_controller.rb
 25 app/controllers/user_tokens_controller.rb
547 total
```

#### 🤔 What was changed? <!-- omit in toc -->

The Rubycritic score increased from `90.34` to `91.34`.

This happened because each controller allowed the isolation of each action and callback and allowed the definition of methods with the same name. (Example: `user_params` instead of `user_registration_params`, `user_session_params`, `user_password_params`...).

Another benefit was the routing definition. It became more readable and easier to understand as it was possible to declare them using only default `REST` actions (index, show, new, create, edit, update, destroy).

#### 🔎 What will the next version have? <!-- omit in toc -->

It shows how the restriction of REST actions can enforce cohesion and ensure controllers are responsible for specific contexts/concepts.

`Next version`: [021-multi-controllers-per-entity_rest-actions-only](https://github.com/solid-process/rails-way-app/tree/021-multi-controllers-per-entity_rest-actions-only?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 021-multi-controllers-per-entity_rest-actions-only

<table>
  <tr><td><strong>Lines of Code</strong></td><td>1361</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.56</td></tr>
</table>

This version ensures that all controllers only have REST actions.

To accomplish this the `task_items#complete` and `task_items#incomplete` actions were moved to their own controller:

| From                             | To                                     |
| -------------------------------- | -------------------------------------- |
| `TaskItemsController#complete`   | `CompleteTaskItemsController#update`   |
| `TaskItemsController#incomplete` | `IncompleteTaskItemsController#update` |

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

#### 🤔 What was changed? <!-- omit in toc -->

The Rubycritic score increased from `91.34` to `91.56`.

This happened because each cohesion has been increased, and the controllers are more specialized.

But lets be honest, the routes are worse than before. 😅

#### 🔎 What will the next version have? <!-- omit in toc -->

Let's do what DHH taught us over a decade ago: https://jeromedalbert.com/how-dhh-organizes-his-rails-controllers/

This will improve the routes and put the controllers in a better structure.

`Next version`: [030-resources-within-namespaces](https://github.com/solid-process/rails-way-app/tree/030-resources-within-namespaces?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 030-resources-within-namespaces

<table>
  <tr><td><strong>Lines of Code</strong></td><td>1361</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.56</td></tr>
</table>

This version implements the ideas presented in this article https://jeromedalbert.com/how-dhh-organizes-his-rails-controllers/, and introduces the concept of `namespaces` to controllers and routes.

**Controllers:**

<table>
  <tr>
    <th>Before</th>
    <th>After</th>
  </tr>
  <tr>
    <td>
      <pre>
app/controllers
├── concerns
│  └── task_items_concern.rb
├── application_controller.rb
├── complete_task_items_controller.rb
├── incomplete_task_items_controller.rb
├── task_items_controller.rb
├── task_lists_controller.rb
├── user_passwords_controller.rb
├── user_profiles_controller.rb
├── user_registrations_controller.rb
├── user_sessions_controller.rb
└── user_tokens_controller.rb</pre>
    </td>
    <td>
      <pre>
app/controllers
├── concerns
│  └── task_items_concern.rb
├── application_controller.rb
├── task
│  ├── items
│  │  ├── complete_controller.rb
│  │  └── incomplete_controller.rb
│  ├── items_controller.rb
│  └── lists_controller.rb
└── user
   ├── passwords_controller.rb
   ├── profiles_controller.rb
   ├── registrations_controller.rb
   ├── sessions_controller.rb
   └── tokens_controller.rb</pre>
    </td>
  </tr>
</table>

**Routes**

<table>
  <tr>
    <th>Before</th>
    <th>After</th>
  </tr>
  <tr>
    <td>
      <pre>
/user_sessions
/user_sessions/new
/user_registrations
/user_registrations/new
/user_passwords
/user_passwords/new
/user_passwords/:id/edit
/user_passwords/:id
/user_profiles/edit
/user_profiles
/user_tokens/edit
/user_tokens
/task_lists/:task_list_id/task_items
/task_lists/:task_list_id/task_items/new
/task_lists/:task_list_id/task_items/:id/edit
/task_lists/:task_list_id/task_items/:id
/task_lists/:task_list_id/complete_task_items/:id
/task_lists/:task_list_id/incomplete_task_items/:id
/task_lists
/task_lists/new
/task_lists/:id/edit
/task_lists/:id</pre>
    </td>
    <td>
      <pre>
/user/sessions
/user/sessions/new
/user/registrations
/user/registrations/new
/user/passwords
/user/passwords/new
/user/passwords/:id/edit
/user/passwords/:id
/user/profiles/edit
/user/profiles
/user/tokens/edit
/user/tokens
/task/lists/:list_id/items
/task/lists/:list_id/items/new
/task/lists/:list_id/items/:id/edit
/task/lists/:list_id/items/:id
/task/lists/:list_id/items/complete/:id
/task/lists/:list_id/items/incomplete/:id
/task/lists
/task/lists/new
/task/lists/:id/edit
/task/lists/:id</pre>
    </td>
  </tr>
</table>

#### 🤔 What was changed? <!-- omit in toc -->

As we can see, the controllers and routes are organized more structuredly. Each main context has its own namespace (`task`, `user`), and the controllers are organized within it.

It is worth noting that the improvement in semantics is reflected in the routes, making them simpler and more readable.

#### 🔎 What will the next version have? <!-- omit in toc -->

Due to the improvement of the structure, the concept of base controllers will be introduced. In other words, controllers within a namespace can have specific (more cohesive) parent classes.

`Next version`: [031-resources-within-namespaces_base-controllers](https://github.com/solid-process/rails-way-app/tree/031-resources-within-namespaces_base-controllers?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 031-resources-within-namespaces_base-controllers

<table>
  <tr><td><strong>Lines of Code</strong></td><td>1355</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.56</td></tr>
</table>

In the branch `021-multi-controllers-per-entity_rest_actions_only`, the `TaskItemsConcern` was introduced to share code among the task item controllers.

However, as with the previously introduced namespaces, this version introduces the concept of base controllers to replace the concern usage. This way, the controllers within a namespace can have specific (more cohesive) parent classes.

See below how the task controllers are organized:

```sh
app/controllers/task
├── items
│  ├── base_controller.rb
│  ├── complete_controller.rb
│  └── incomplete_controller.rb
└── items_controller.rb
```

```ruby
Task::ItemsController < Task::Items::BaseController
Task::Items::CompletedController < Task::Items::BaseController
Task::Items::IncompleteController < Task::Items::BaseController
```

#### 🤔 What are the benefits of using base controllers? <!-- omit in toc -->

Since the previous version, we can see that the Rubycritic score has remained the same, which is positive given that the improvements in the structure do not complicate the existing implementation.

Although the score has not changed, we can see how this grouping reduces the effort to understand and find your way around the code. This also translates into increased cohesion, not at the class level but at the namespace level (groups of classes and modules).

#### 🔎 What will the next version have? <!-- omit in toc -->

The cohesion ideas (organization and grouping guided to a specific purpose) will be applied to views and partials. Check out to see the benefits of this approach.

`Next version`: [032-resources-within-namespaces_partials-grouped-by-context](https://github.com/solid-process/rails-way-app/tree/032-resources-within-namespaces_partials-grouped-by-context?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 032-resources-within-namespaces_partials-grouped-by-context

<table>
  <tr><td><strong>Lines of Code</strong></td><td>1355</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.56</td></tr>
</table>

The previous version revealed the benefits of group controller within namespaces. This version will apply the same ideas to the view partials.

Let's see comparation between the previous and current structure:

<table>
  <tr>
    <th>Previous</th>
    <th>Current</th>
  </tr>
  <tr>
    <td>
      <pre>
app/views
├── shared
│  ├── settings
│  │  └── _header.html.erb
│  ├── tasks
│  │  ├── _add_new.html.erb
│  │  └── _header.html.erb
│  └── users
│     ├── _header.html.erb
│     ├── _reset_password_link.html.erb
│     ├── _sign_in_link.html.erb
│     ├── _sign_up_link.html.erb
│     └── user_token.json.jbuilder
└── task
   ├── items
   │  ├── _delete_action.html.erb
   │  ├── _edit_action.html.erb
   │  ├── _toggle_status_action.html.erb
   └── lists
      ├── _delete_action.html.erb
      ├── _edit_action.html.erb
      └── _view_items_action.html.erb</pre>
    </td>
    <td>
      <pre>
app/views
├── task
│  ├── items
│  │  ├── actions
│  │  │  ├── _delete.html.erb
│  │  │  ├── _edit.html.erb
│  │  │  └── _toggle_status.html.erb
│  ├── lists
│  │  ├── actions
│  │  │  ├── _delete.html.erb
│  │  │  ├── _edit.html.erb
│  │  │  └── _view_items.html.erb
│  └── shared
│     ├── _add_new.html.erb
│     └── _header.html.erb
└── user
   └── shared
      ├── _header.html.erb
      ├── links
      │  ├── _reset_password.html.erb
      │  ├── _sign_in.html.erb
      │  └── _sign_up.html.erb
      └── settings
         └── _header.html.erb</pre>
    </td>
  </tr>
</table>

#### 🤔 Why is this structure more cohesive than the previous one? <!-- omit in toc -->

To answer this, let's analyze the partials in the app/views/shared folder from the previous version. It was less cohesive because it knew all the application contexts (settings, tasks, and users).

The current version shows that these partials have been moved to task or user contexts. This change created a more cohesive structure because of the lower indirection and greater specificity of each partial's use.

#### 🔎 What will the next version have? <!-- omit in toc -->

Aiming increasing the cohesion of the application, the next version will move the mailer views under the entity user context.

`Next version`: [033-resources-within-namespaces_mailers-under-entity-context](https://github.com/solid-process/rails-way-app/tree/033-resources-within-namespaces_mailers-under-entity-context?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 033-resources-within-namespaces_mailers-under-entity-context

<table>
  <tr><td><strong>Lines of Code</strong></td><td>1356</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.56</td></tr>
</table>

This version continues system cohesion improvement by moving user mailer views from app/views/user_mailers to app/views/user/mailers.

```sh
app/views/user
├── mailers
│  ├── email_confirmation.html.erb
│  ├── email_confirmation.text.erb
│  ├── reset_password.html.erb
│  └── reset_password.text.erb
├── passwords/
├── profiles/
├── registrations/
├── sessions/
├── shared/
└── tokens/
```

#### 🤔 Why is this structure more cohesive than the previous one? <!-- omit in toc -->

Because the mailer views are now located under the user entity context.

#### 🔎 What will the next version have? <!-- omit in toc -->

Aiming to increase cohesion, the next version will add another nested namespace to isolate all user settings resources.

`Next version`: [034-resources-within-namespaces_nested-namespaces](https://github.com/solid-process/rails-way-app/tree/034-resources-within-namespaces_nested-namespaces?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 034-resources-within-namespaces_nested-namespaces

<table>
  <tr><td><strong>Lines of Code</strong></td><td>1356</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>91.56</td></tr>
</table>

This version pushes the cohesion further by creating another nested namespace (`User::Settings`).

<table>
  <tr>
    <th>Before</th>
    <th>After</th>
  </tr>
  <tr>
    <td>
      <pre>
app/views/user
├── mailers/
├── passwords/
├── profiles/
├── registrations/
├── sessions/
├── shared
│  ├── links
│  └── settings
└── tokens
app/controllers/user
├── passwords_controller.rb
├── profiles_controller.rb
├── registrations_controller.rb
├── sessions_controller.rb
└── tokens_controller.rb</pre>
    </td>
    <td>
      <pre>
app/views/user
├── mailers/
├── passwords/
├── registrations/
├── sessions/
├── settings
│  ├── profiles/
│  └── tokens/
└── shared
   └── links/
app/controllers/user
├── passwords_controller.rb
├── registrations_controller.rb
├── sessions_controller.rb
└── settings
   ├── profiles_controller.rb
   └── tokens_controller.rb</pre>
    </td>
  </tr>
</table>

#### 🤔 Why is this structure more cohesive than the previous one? <!-- omit in toc -->

Because all user settings resources are isolated in the same namespace (`User::Settings`), which makes it easier to maintain and understand the codebase.

#### 🔎 What will the next version have? <!-- omit in toc -->

Aiming to improve the expressiveness of the application, the next version will make more use of singular resources.

`Next version`: [035-resources-within-namespaces_singular_resources](https://github.com/solid-process/rails-way-app/tree/035-resources-within-namespaces_singular_resources?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 035-resources-within-namespaces_singular_resources

<table>
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

#### 🤔 Why does consistency matter? <!-- omit in toc -->

> Conceptual Integrity:
> In 1975, FredBrooks said: I will contend that Conceptual Integrity is the most important consideration in system design. It _**is better**_ to have a system omit certain anomalous features and improvements, but to reflect one set of design ideas, _**than**_ to have one that contains many good but independent and uncoordinated ideas.

Consistency is a key factor in the maintainability of a system. It makes it easier to understand and as a consequence, easier to maintain (promote changes).

This is applicable to everything in the system, from the code to the user interface.

This applies to everything in the system, from the code to the user interface. This branch was added to add this concept to the spotlight.

#### 🔎 What will the next version have? <!-- omit in toc -->

Aiming to improve the application consistency, the following version groups some models within namespaces.

`Next version`: [040-models-within-namespaces](https://github.com/solid-process/rails-way-app/tree/040-models-within-namespaces?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 040-models-within-namespaces

<table>
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

### 🤔 Why does this change matter? <!-- omit in toc -->

Cohesion + consistency = maintainability.

### 🔎 What will the next version have? <!-- omit in toc -->

There have been seven iterations since the version named `021-multi-controllers-per-entity_rest_actions_only`, but the Rubycritic score has remained the same (_**91.56**_).

But what was the reason?

The same controllers handle both the web application and the REST API. In other words, there needs to be more cohesion since each request format serves different purposes.

Because of this, the next version will perform this separation, and with this, it will be possible to determine whether or not this care in promoting cohesion will improve the quality score.

`Next version`: [050-separation-of-entry-points](https://github.com/solid-process/rails-way-app/tree/050-separation-of-entry-points?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 050-separation-of-entry-points

<table>
  <tr><td><strong>Lines of Code</strong></td><td>1462</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>94.04</td></tr>
</table>

This version shows a substantial increase in the Rubycritic score, from `91.56` to `94.04`. The reason for this growth was the separation between the Web and REST API controllers and routes. Before that, both formats were handled by a single controller.

This separation of concerns reflects how cohesive each of these contexts has become.

See how the controllers and views are now organized:

**Controllers**

<table>
  <tr>
    <th>Web</th>
    <th>API::V1</th>
  </tr>
  <tr>
    <td>
      <pre>
app/controllers/web
├── base_controller.rb
├── task
│  ├── items
│  │  ├── base_controller.rb
│  │  ├── complete_controller.rb
│  │  └── incomplete_controller.rb
│  ├── items_controller.rb
│  └── lists_controller.rb
└── user
   ├── passwords_controller.rb
   ├── registrations_controller.rb
   ├── sessions_controller.rb
   └── settings
      ├── profiles_controller.rb
      └── tokens_controller.rb</pre>
    </td>
    <td>
      <pre>
app/controllers/api
└── v1
   ├── base_controller.rb
   ├── task
   │  ├── items
   │  │  ├── base_controller.rb
   │  │  ├── complete_controller.rb
   │  │  └── incomplete_controller.rb
   │  ├── items_controller.rb
   │  └── lists_controller.rb
   └── user
      ├── passwords
      │  └── resettings_controller.rb
      ├── passwords_controller.rb
      ├── registrations_controller.rb
      ├── sessions_controller.rb
      └── tokens_controller.rb</pre>
    </td>
  </tr>
</table>

**Views**

<table>
  <tr>
    <th>Web</th>
    <th>API::V1</th>
  </tr>
  <tr>
    <td>
      <pre>
app/views/web
├── task
│  ├── items
│  │  ├── _form.html.erb
│  │  ├── actions
│  │  │  ├── _delete.html.erb
│  │  │  ├── _edit.html.erb
│  │  │  └── _toggle_status.html.erb
│  │  ├── edit.html.erb
│  │  ├── index.html.erb
│  │  ├── new.html.erb
│  │  └── show.html.erb
│  ├── lists
│  │  ├── _form.html.erb
│  │  ├── actions
│  │  │  ├── _delete.html.erb
│  │  │  ├── _edit.html.erb
│  │  │  └── _view_items.html.erb
│  │  ├── edit.html.erb
│  │  ├── index.html.erb
│  │  ├── new.html.erb
│  │  └── show.html.erb
│  └── shared
│     ├── _add_new.html.erb
│     └── _header.html.erb
└── user
   ├── passwords
   │  ├── edit.html.erb
   │  └── new.html.erb
   ├── registrations
   │  └── new.html.erb
   ├── sessions
   │  └── new.html.erb
   ├── settings
   │  ├── _header.html.erb
   │  ├── profiles
   │  │  └── edit.html.erb
   │  └── tokens
   │     └── edit.html.erb
   └── shared
      ├── _header.html.erb
      └── links
         ├── _reset_password.html.erb
         ├── _sign_in.html.erb
         └── _sign_up.html.erb</pre>
    </td>
    <td>
      <pre>
app/views/api
└── v1
   ├── errors
   │  ├── _response.json.jbuilder
   │  ├── from_model.json.jbuilder
   │  ├── response.json.jbuilder
   │  └── unauthorized.json.jbuilder
   ├── task
   │  ├── items
   │  │  ├── _record.json.jbuilder
   │  │  ├── index.json.jbuilder
   │  │  └── show.json.jbuilder
   │  └── lists
   │     ├── _record.json.jbuilder
   │     ├── index.json.jbuilder
   │     └── show.json.jbuilder
   └── user
      └── token.json.jbuilder</pre>
    </td>
  </tr>
</table>

#### 🤔 Why does this change matter? <!-- omit in toc -->

In addition to the increased cohesion, we can also see each context has the freedom to represent and organize its resources semantically.

For example, the web application uses the profile to update passwords. When we look at this resource, we see `web/user/settings/profiles`. However, the same responsibility was reflected differently in the API: `api/v1/user/passwords`.

_**This was unfeasible with the previous approach!**_

#### 🔎 What will the next version have? <!-- omit in toc -->

Apart from adding namespaces, the implementation of models has stayed the same so far.

Although this version improved the Rubycritic score significantly, it introduced duplication in controllers.

The next version will remove this duplication by concentrating logic in models.

`Next version`: [051-separation-of-entry-points_fat-models](https://github.com/solid-process/rails-way-app/tree/051-separation-of-entry-points_fat-models?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 051-separation-of-entry-points_fat-models

<table>
  <tr><td><strong>Lines of Code</strong></td><td>1456</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>95.56</td></tr>
</table>

This version increases the Rubycritic score from `94.04` to `95.56` by moving the existing duplications to the models, the famous fat models and skinny controllers.

#### 🤔 Why does this change matter? <!-- omit in toc -->

Because eliminating duplication generally increases maintenance.

_**But be careful:**_ excessive and indiscriminate use of DRY (Don't Repeat Yourself) can compromise understanding and maintenance.

Try to create abstractions only to address real needs (real problems).

#### 🔎 What will the next version have? <!-- omit in toc -->

In the next version, we will enrich the application's domain model, starting with the Current class, which contains different responsibilities and a higher level of complexity.

`Next version`: [060-domain-model_account-member-poro](https://github.com/solid-process/rails-way-app/tree/060-domain-model_account-member-poro?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 060-domain-model_account-member-poro

<table>
  <tr><td><strong>Lines of Code</strong></td><td>1504</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>95.63</td></tr>
</table>

The `Current` class had two responsibilities: containing thread-safe shared state and queries to authorize user access.

This branch separates these responsibilities, keeping the primary scope of the `Current` class (containing thread-safe and shareable state) but moving the authorization responsibility to the `Account::Member` and `Account::Member::Authorization` POROS (Plain Old Ruby Objects).

POROS means a model that doesn't inherit from `ActiveRecord`, and it's a common pattern to extract complex logic from `ActiveRecord` models.

#### 🤔 Why does this change matter? <!-- omit in toc -->

Cohesion + Separation of Concerns = Better understanding, maintainability and testability.

#### 🔎 What will the next version have? <!-- omit in toc -->

In the next version, we will enrich the application's domain model, starting with the Current class, which contains different responsibilities and a higher level of complexity.

`Next version`: [061-domain-model_user-token-poro](https://github.com/solid-process/rails-way-app/tree/061-domain-model_user-token-poro?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 061-domain-model_user-token-poro

<table>
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

#### 🤔 Why does this change matter? <!-- omit in toc -->

This change matters because it's a good practice to extract complex logic from `ActiveRecord` models. As a result, the Rubycritc score increased again, from `95.63` to `95.68`.

#### 🔎 What will the next version have? <!-- omit in toc -->

The next version will isolate some strings into constants to reduce codebase duplication and fragility (weak references).

`Next version`: [062-domain-model_task-constants](https://github.com/solid-process/rails-way-app/tree/062-domain-model_task-constants?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 062-domain-model_task-constants

<table>
  <tr><td><strong>Lines of Code</strong></td><td>1526</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>95.78</td></tr>
</table>

This branch continues to enrich the domain model with a simple change. It ensures that the strings "completed" and "incomplete" are transformed into constants, `Task::COMPLETED` and `Task::INCOMPLETE`.

Note that this change also increases the Rubycritic score from `95.68` to `95.78`.

#### 🤔 Why does this change matter? <!-- omit in toc -->

> Coupling is good when it is stable.

Before this change, breaking the behavior by committing a typo anywhere coupled to these strings would be possible. Now, using constants, we have a single reference for all usage points in the

#### 🔎 What will the next version have? <!-- omit in toc -->

The next iteration will extract complex operations from the models into specialized POROs.

`Next version`: [063-domain-model_user-operations](https://github.com/solid-process/rails-way-app/tree/063-domain-model_user-operations?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 063-domain-model_user-operations

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

#### 🤔 Why does this change matter? <!-- omit in toc -->

Can you imagine a model with hundreds of lines of code? It's hard to maintain, right? By isolating some operations into specialized POROs, we can reduce the complexity and make things easier to maintain.

Beyond this, did you see that the file and folder structure reveals the domain model and what kind of operations that context can do?

This approach can distribute the complexity over specialized classes and, as a side effect, increase the codebase's understandability.

#### 🔎 What will the next version have? <!-- omit in toc -->

The next iteration will define the account context and decouple the user model from it to make the codebase even more orthogonal (orthogonality = the ability to change one thing without any unseen effect on other things).

`Next version`: [070-orthogonal-models](https://github.com/solid-process/rails-way-app/tree/070-orthogonal-models?tab=readme-ov-file).

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>

---

### 070-orthogonal-models

<table>
  <tr><td><strong>Lines of Code</strong></td><td>1613</td></tr>
  <tr><td><strong>Rubycritic Score</strong></td><td>95.81</td></tr>
</table>

**Orthogonality** is the ability to change one thing without any unseen effects on other things.

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

#### 🤔 Why does this change matter? <!-- omit in toc -->

The `User` model is now more focused on the user's behavior, while the `Account` model is more focused on the account's behavior.

This separation reduces the changes of undesired side effects when changing one of the models. This also happened when the Web and REST API resources were separated.

Another thing to notice is Rubycritic score which increased from `95.77` to `95.81`, reflecting the high cohesion and low coupling of the codebase.

#### 🔎 What will the next version have? <!-- omit in toc -->

That's all folks! There is no other branch. 😉

After all these iterations, I hope you can see the enormous difference that focusing on cohesion and coupling can make in a codebase and how a framework like Rails (which has influenced so many others) is flexible enough to accommodate all these different approaches.

Ruby and Rails rock! 🤘😎

<p align="right"><a href="#-table-of-contents-">⬆ back to top</a></p>
