# Simple git sync checker

This script will traverse a directory looking for git repositories and check
if they are behind the remote filtering for the remmote url by text string.

```
pipenv install --three
pipenv shell
checkgit --help
```
or

```
pipenv run checkgit --help
# traverse repo root and push repo back to github if they have a remote
pipenv run checkgit --path ../../../ --url github
```
