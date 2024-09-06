<small>

> `MENU` [README](../README.md) | [How to run locally](./00_INSTALLATION.md) | **REST API doc** | [Web app screenshots](./02_WEB_APP_SCREENSHOTS.md) | [Branch descriptions](./03_BRANCH_DESCRIPTIONS.md)

</small>

# 🚆 Rails Way App <!-- omit in toc -->

REST API documentation (cURL examples).

## Versions

Although the REST API behavior is the same, the endpoints may vary depending on the branch.

You can use the links below to access the documentation for the desired version.

| LOC / GRADE  | Branch |
| ------------ | ------ |
| 1326 / 89.23 | [010-one-controller-per-entity](https://github.com/solid-process/rails-way-app/blob/010-one-controller-per-entity/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1350 / 90.34 | [011-one-controller-per-entity_user-concerns](https://github.com/solid-process/rails-way-app/blob/011-one-controller-per-entity_user-concerns/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1342 / 91.34 | [020-multi-controllers-per-entity](https://github.com/solid-process/rails-way-app/blob/020-multi-controllers-per-entity/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1361 / 91.56 | [021-multi-controllers-per-entity_rest-actions-only](https://github.com/solid-process/rails-way-app/blob/021-multi-controllers-per-entity_rest-actions-only/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1361 / 91.56 | [030-resources-within-namespaces](https://github.com/solid-process/rails-way-app/blob/030-resources-within-namespaces/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1355 / 91.56 | [031-resources-within-namespaces_base-controllers](https://github.com/solid-process/rails-way-app/blob/031-resources-within-namespaces_base-controllers/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1355 / 91.56 | [032-resources-within-namespaces_partials-grouped-by-context](https://github.com/solid-process/rails-way-app/blob/032-resources-within-namespaces_partials-grouped-by-context/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1356 / 91.56 | [033-resources-within-namespaces_mailers-under-entity-context](https://github.com/solid-process/rails-way-app/blob/033-resources-within-namespaces_mailers-under-entity-context/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1356 / 91.56 | [034-resources-within-namespaces_nested-namespaces](https://github.com/solid-process/rails-way-app/blob/034-resources-within-namespaces_nested-namespaces/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1356 / 91.56 | [035-resources-within-namespaces_singular_resources](https://github.com/solid-process/rails-way-app/blob/035-resources-within-namespaces_singular_resources/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1359 / 91.56 | [040-models-within-namespaces](https://github.com/solid-process/rails-way-app/blob/040-models-within-namespaces/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1462 / 94.04 | [050-separation-of-entry-points](https://github.com/solid-process/rails-way-app/blob/050-separation-of-entry-points/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1456 / 95.56 | [051-separation-of-entry-points_fat-models](https://github.com/solid-process/rails-way-app/blob/051-separation-of-entry-points_fat-models/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1504 / 95.63 | [060-domain-model_account-member-poro](https://github.com/solid-process/rails-way-app/blob/060-domain-model_account-member-poro/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1519 / 95.68 | [061-domain-model_user-token-poro](https://github.com/solid-process/rails-way-app/blob/061-domain-model_user-token-poro/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1526 / 95.78 | [062-domain-model_task-constants](https://github.com/solid-process/rails-way-app/blob/062-domain-model_task-constants/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1563 / 95.77 | [063-domain-model_user-operations](https://github.com/solid-process/rails-way-app/blob/063-domain-model_user-operations/docs/01_REST_API_DOC.md#-table-of-contents-) |
| 1613 / 95.81 | [070-orthogonal-models](https://github.com/solid-process/rails-way-app/blob/070-orthogonal-models/docs/01_REST_API_DOC.md#-table-of-contents-) |

The following commands were used to generate the LOC and GRADE reports:
- **LOC** (lines of code): `bin/rails stats`
- **GRADE** (code quality): `bin/rails rubycritic`
