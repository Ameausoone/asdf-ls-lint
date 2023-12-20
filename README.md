<div align="center">

# asdf-ls-lint [![Build](https://github.com/ameausoone/asdf-ls-lint/actions/workflows/build.yml/badge.svg)](https://github.com/ameausoone/asdf-ls-lint/actions/workflows/build.yml) [![Lint](https://github.com/ameausoone/asdf-ls-lint/actions/workflows/lint.yml/badge.svg)](https://github.com/ameausoone/asdf-ls-lint/actions/workflows/lint.yml)

[ls-lint](https://ls-lint.org/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

# Install

Plugin:

```shell
asdf plugin add ls-lint
# or
asdf plugin add ls-lint https://github.com/ameausoone/asdf-ls-lint.git
```

ls-lint:

```shell
# Show all installable versions
asdf list-all ls-lint

# Install specific version
asdf install ls-lint latest

# Set a version globally (on your ~/.tool-versions file)
asdf global ls-lint latest

# Now ls-lint commands are available
ls-lint -h
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/ameausoone/asdf-ls-lint/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Antoine Meausoone](https://github.com/ameausoone/)
