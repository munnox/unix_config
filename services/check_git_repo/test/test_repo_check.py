from check_git_repo import check_remote_url, get_git_list
import pytest
import yaml

# Basic remote url test set
testdata = [
    pytest.param("https://github.com", "github", True, id="github find test"),
    pytest.param("https://github.com", "other", False, id="github not find test"),
    pytest.param("https://gitlab.com", "gitlab", True, id="gitlab find test"),
    pytest.param("https://gitlab.com", "other", False, id="gitlab not find test"),
]


@pytest.mark.parametrize("remote_url,test_url,result", testdata)
def test_remote_url(remote_url: str, test_url: str, result: bool):
    assert check_remote_url(remote_url, test_url) == result


# Simple test to look in the local directory
def test_git_list(snapshot):
    snapshot.snapshot_dir = "test_snapshots"
    snapshot.assert_match(
        yaml.dump(get_git_list("../")), "get_git_list.yaml"
    )
