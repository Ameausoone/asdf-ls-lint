# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

# TODO: adapt this
asdf plugin test ls-lint https://github.com/ameausoone/asdf-ls-lint.git "ls-lint -h"
```

Tests are automatically run in GitHub Actions on push and PR.
