# dotnet-test-gh-action

This action performs a _dotnet test_ on any solution (.sln file) inside the specified folder. The (required) input is _app-path_. Here is an example:

```yaml
name: CI
on:
  pull_request:
    branches: ["main"]
jobs:
    build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: ohpensource/dotnet-test-gh-action@latest
        name: Test dotnet application
        with:
          app-path: "src"
```
