<a name="unreleased"></a>
## [Unreleased]



<a name="v0.13.1"></a>
## [v0.13.1] - 2021-05-10

- fix: incorrect link in changelog config
- docs: update changelog


<a name="v0.13.0"></a>
## [v0.13.0] - 2021-05-10

- Merge pull request [#8](https://github.com/terraform-module/terraform-kubernetes-velero/issues/8) from terraform-module/readme
- fix: chlog updated
- chore: update release drafter and stale setup as now they derive setup from .github
- chore: remove issue templates. we do not need automerger right now and bump release to tfm 0.13. skip
- chore: update readme. skip


<a name="v0.12.11"></a>
## [v0.12.11] - 2021-05-10

- Merge pull request [#7](https://github.com/terraform-module/terraform-kubernetes-velero/issues/7) from jverce/remove-deprecated-function-calls
- Run project validations
- Decouple installation name from Kubernetes namespace name
- Use a data source for Kubernetes namespace
- Refactor usage of deprecated `list` function

###

[Terraform docs](https://www.terraform.io/docs/language/functions/list.html)
* Move hardcoded `serviceAccount` values into a template YAML file


<a name="v0.12.10"></a>
## [v0.12.10] - 2021-04-25

- Merge pull request [#6](https://github.com/terraform-module/terraform-kubernetes-velero/issues/6) from jverce/fix-typos-in-doc
- Add back the $ sign in the command examples
- Fix some typos on the docs


<a name="v0.12.9"></a>
## [v0.12.9] - 2020-12-15

- Merge pull request [#3](https://github.com/terraform-module/terraform-kubernetes-velero/issues/3) from gozer/issue/2/iam_deploy
- Merge branch 'master' into issue/2/iam_deploy
- Add iam_deploy option, defaults to true


<a name="v0.12.8"></a>
## [v0.12.8] - 2020-12-13

- Merge pull request [#5](https://github.com/terraform-module/terraform-kubernetes-velero/issues/5) from gozer/issue/4/iam-role-name
- Add `iam_role_name` option, default stays the same


<a name="v0.12.7"></a>
## [v0.12.7] - 2020-10-10

- Merge pull request [#1](https://github.com/terraform-module/terraform-kubernetes-velero/issues/1) from samanthaq/velero-chart-version-v2.13.2
- bump velero/velero chart to version v2.13.2


<a name="v0.12.6"></a>
## [v0.12.6] - 2020-07-26

- do not ouput flaky namespace metadata


<a name="v0.12.5"></a>
## [v0.12.5] - 2020-07-20

- rename vars to app. default history is 1


<a name="v0.12.4"></a>
## [v0.12.4] - 2020-07-19

- changelog updated


<a name="v0.12.3"></a>
## [v0.12.3] - 2020-07-19

- changelog updated


<a name="v0.12.2"></a>
## [v0.12.2] - 2020-07-19

- velero is working on eks with web identity setup


<a name="v0.12.1"></a>
## v0.12.1 - 2020-07-19

- Initial commit


[Unreleased]: https://github.com/terraform-module/terraform-kubernetes-velero/compare/v0.14.0...HEAD
[v0.14.0]: https://github.com/terraform-module/terraform-kubernetes-velero/compare/v0.13.0...v0.14.0
[v0.13.0]: https://github.com/terraform-module/terraform-kubernetes-velero/compare/v0.12.11...v0.13.0
[v0.12.11]: https://github.com/terraform-module/terraform-kubernetes-velero/compare/v0.12.10...v0.12.11
[v0.12.10]: https://github.com/terraform-module/terraform-kubernetes-velero/compare/v0.12.9...v0.12.10
[v0.12.9]: https://github.com/terraform-module/terraform-kubernetes-velero/compare/v0.12.8...v0.12.9
[v0.12.8]: https://github.com/terraform-module/terraform-kubernetes-velero/compare/v0.12.7...v0.12.8
[v0.12.7]: https://github.com/terraform-module/terraform-kubernetes-velero/compare/v0.12.6...v0.12.7
[v0.12.6]: https://github.com/terraform-module/terraform-kubernetes-velero/compare/v0.12.5...v0.12.6
[v0.12.5]: https://github.com/terraform-module/terraform-kubernetes-velero/compare/v0.12.4...v0.12.5
[v0.12.4]: https://github.com/terraform-module/terraform-kubernetes-velero/compare/v0.12.3...v0.12.4
[v0.12.3]: https://github.com/terraform-module/terraform-kubernetes-velero/compare/v0.12.2...v0.12.3
[v0.12.2]: https://github.com/terraform-module/terraform-kubernetes-velero/compare/v0.12.1...v0.12.2
