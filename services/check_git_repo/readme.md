# Simple git sync checker

This script will traverse a directory looking for git repositories and check
if they are behind the remote filtering for the remmote url by text string.

```
poetry install --three
poetry shell
poetry run python main.py --help
```
or

```
poetry run main.py --help
# traverse repo root and push repo back to github if they have a remote
poetry run main.py --path ../../../ --url github.com
poetry run python main.py --path ~/repo/ --assess_only
```

To run and update tests:

```
poetry run pytest
poetry run pytest --snapshot-update
```