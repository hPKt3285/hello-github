# hello-github

A small sandbox for practising Git and GitHub workflows, and for checking that the SSH
setup on a machine works before it is used for anything important.

## What it is used for

- Confirming that SSH authentication and commit signing work after a fresh setup
- Practising the branch → commit → pull request → merge flow
- Testing GitHub Actions on a repository where a broken workflow costs nothing

## Checking the connection

```bash
ssh -T git@github.com
git ls-remote git@github.com:hPKt3285/hello-github.git
```

The greeting from the first command is a success message, not an error: GitHub answers
over SSH but does not provide a shell.

## Running the checks locally

The same checks that CI runs can be executed on any machine with Bash:

```bash
bash scripts/check-readme.sh
```

## Continuous integration

[`.github/workflows/readme.yml`](.github/workflows/readme.yml) runs on every push and
pull request. It checks that the README exists, still has a title and at least one
section, and contains no trailing whitespace. The checks themselves live in
[`scripts/check-readme.sh`](scripts/check-readme.sh), so CI and a local run execute the
same code instead of two copies that drift apart. The workflow is deliberately small — it
is a place to learn how Actions reports failures, not a real test suite.

The same script runs in two jobs: `readme` on `ubuntu-latest`, and `readme-windows` on
`windows-latest` with `shell: bash`. The second job exists to catch line-ending or shell
differences that an Ubuntu-only run would never see; both currently pass.

## Notes

- Default branch: `main`
- Commits are signed with an SSH key, so they show up as *Verified* on GitHub
- [`.gitattributes`](.gitattributes) keeps shell scripts at LF, so the same file runs on
  Windows and on the Ubuntu runner
