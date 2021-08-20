import os
import time

#  https://gitpython.readthedocs.io/en/stable/tutorial.html
from git import Repo
from git.exc import GitCommandError


class bcolors:
    """console colors

    Source https://stackoverflow.com/questions/287871/how-to-print-colored-text-in-python
    """

    HEADER = "\033[95m"
    OKBLUE = "\033[94m"
    OKCYAN = "\033[96m"
    OKGREEN = "\033[92m"
    WARNING = "\033[93m"
    FAIL = "\033[91m"
    ENDC = "\033[0m"
    BOLD = "\033[1m"
    UNDERLINE = "\033[4m"


def get_local_path(path):
    return os.path.abspath(os.path.expanduser(path))


def check_remote_url(remote_url, url):
    """Check a remote url for url part."""
    if url != "":
        if remote_url.find(url) >= 0:
            return True
        else:
            return False
    return True


def get_git_list(root_path):
    """Search a file path to sub directories containing '.git' folders."""
    repos_to_process = []
    for root, dirs, files in os.walk(root_path, topdown=False):
        #  for name in files:
        #      print(os.path.join(root, name))
        repos_to_process.append({"root": root, "git": ".git" in dirs})
        #  print(f"git directory found: {root}")
    return repos_to_process


def process_repo(root, url, assess_only, push, pull, verbose=False):
    repo = Repo(root)
    assert not repo.bare

    logs = []
    remotes_matched = []
    for remote in repo.remotes:
        if check_remote_url(remote.url, url) or assess_only:
            remotes_matched.append(remote)

    logs.append(f"{bcolors.HEADER}Respository: '{root}'{bcolors.ENDC}")
    logs.append(f"Remotes in Repository Matched: {[r.name for r in remotes_matched]}")
    if len(remotes_matched) > 0:
        try:
            headcommit = repo.head.commit
            commit_str = time.strftime(
                "%a, %d %b %y %h:%m", time.gmtime(headcommit.committed_date)
            )
            author_str = time.strftime(
                "%a, %d %b %y %h:%m", time.gmtime(headcommit.authored_date)
            )
            logs.append(
                f"{bcolors.OKCYAN}Commit info {headcommit.hexsha} {headcommit.author.name} {commit_str} {author_str}{bcolors.ENDC}"
            )
        except Exception as error:
            logs.append(
                f"{bcolors.FAIL}Git head issue: {root} {repo.heads}{bcolors.ENDC}"
            )
            #  raise error
            #  continue

        logs.append(f"Repo Branches: {[b.name for b in repo.heads]}")
        for remote in remotes_matched:
            logs.append(
                f"Remotes: {remote.name} -[mapped to]-> {remote.url}. Remote Refs/Branches: {[b.name for b in remote.refs]}"
            )
            logs.append(f"Assess only: {assess_only}")

            if assess_only:
                continue

            if not check_remote_url(remote.url, url):
                continue
            try:
                fetch_results = remote.fetch()
                logs.append(f"fetching remotes")
            except GitCommandError as error:
                logs.append(
                    f"{bcolors.FAIL} unable to fetch remote {remote} {error}{bcolors.ENDC}"
                )

            for repo_branch in repo.heads:
                for remote_refs in remote.refs:
                    remote_branch = remote_refs.name
                    if remote_branch.find(repo_branch.name) >= 0:
                        try:
                            behind_commits = list(
                                repo.iter_commits(
                                    f"{repo_branch.name}..{remote.name}/{repo_branch.name}"
                                )
                            )
                            ahead_commits = list(
                                repo.iter_commits(
                                    f"{remote.name}/{repo_branch.name}..{repo_branch.name}"
                                )
                            )
                        except GitCommandError as error:
                            logs.append(
                                f"{bcolors.FAIL}Cannot calculate the remote reference Error: '{error}'{bcolors.ENDC}"
                            )
                            behind_commits = []
                            ahead_commits = []

                        behind_string = (
                            f"{bcolors.OKGREEN}{len(behind_commits)}{bcolors.ENDC}"
                        )
                        if len(behind_commits) > 0:
                            behind_string = (
                                f"{bcolors.WARNING}{len(behind_commits)}{bcolors.ENDC}"
                            )
                        ahead_string = (
                            f"{bcolors.OKGREEN}{len(ahead_commits)}{bcolors.ENDC}"
                        )
                        if len(ahead_commits) > 0:
                            ahead_string = (
                                f"{bcolors.WARNING}{len(ahead_commits)}{bcolors.ENDC}"
                            )
                        logs.append(
                            f"Behind-{behind_string} Ahead-{ahead_string}. Branch mapping local -> remote: {repo_branch} -> {remote_branch} "
                        )
                        if len(behind_commits) == 0 and len(ahead_commits) > 0:
                            logs.append(
                                f"{bcolors.WARNING}Would be useful to push append '--push' to the call{bcolors.ENDC}"
                            )
                            if push:
                                pushinfolist = remote.push()
                                for pushinfo in pushinfolist:
                                    logs.append(
                                        f"{bcolors.OKGREEN}Pushing to remote {pushinfo.summary} was at {pushinfo.old_commit}{bcolors.ENDC}"
                                    )
                        if len(behind_commits) > 0 and len(ahead_commits) == 0:
                            logs.append(
                                f"{bcolors.WARNING}Would be useful to pull append '--pull' to the call{bcolors.ENDC}"
                            )
                            if pull:
                                pullinfolist = remote.pull()
                                for pullinfo in pullinfolist:
                                    logs.append(
                                        f"{bcolors.OKGREEN}Pulling to remote {pullinfo.summary} was at {pullinfo.old_commit}{bcolors.ENDC}"
                                    )
            logs.append("")
    return logs
