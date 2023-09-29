from collections import namedtuple
import os
import time

#  https://gitpython.readthedocs.io/en/stable/tutorial.html
from git import Repo
from git.exc import GitCommandError
import logging

logger = logging.getLogger(__name__)

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

class Compare(
        namedtuple("Compare",
            [
                'branch_name', 'ref_name', 'ahead_commits',
                'behind_commits', 'should_pull', 'should_push'
            ]
        )):
    def get_dict_summary(self):
        d = self._asdict()
        d['ahead_commits'] = len(d['ahead_commits'])
        d['behind_commits'] = len(d['behind_commits'])
        return d

class RepoAssessor:

    def __init__(self, root, url, assess_only, push , pull, verbose=False):
        self.root = root
        self.repo: Repo = Repo(self.root)
        self.assess_only = assess_only
        self.url = url
        self.push = push
        self.pull = pull
        self.verbose = verbose
        self.logs = []
        self.fetch_timeout = 30
        self.compares: list[Compare] = []
        # self.ahead_commits = []
        # self.behind_commits = []
        # self.should_push = False
        # self.should_pull = False

        assert not self.repo.bare

        self.remotes_matched = []
        for remote in self.repo.remotes:
            if check_remote_url(remote.url, url) or assess_only:
                self.remotes_matched.append(remote)

    def get_dict_summary(self):
        compares = [c.get_dict_summary() for c in self.compares]
        compares_dict = {
            c['ref_name']: c
            for c in compares
        }
        d = {
            "root": self.root,
            "branches": [b.name for b in self.repo.heads],
            "remotes": [
                {
                    "name": r.name,
                    "url": r.url,
                    "compare": compares_dict[r.name]
                }
                for r in self.repo.remotes
            ],
            # "compares": compares_dict,
            # "should_push": self.should_push,
            # "should_pull": self.should_pull,
            # "ahead_commit_length": len(self.ahead_commits),
            # "behind_commit_length": len(self.behind_commits),
        }
        return d

    def process_repo(self):

        msg = f"{bcolors.HEADER}Respository: '{self.root}' Remote urls Matched: {[r.name for r in self.remotes_matched]}{bcolors.ENDC}"
        # logger.info(f"Respository: '{self.root}'")
        # self.logs.append(f"{bcolors.HEADER}Respository: '{self.root}'{bcolors.ENDC}")
        logger.info(msg)
        self.logs.append(msg)
        if len(self.remotes_matched) > 0:
            try:
                headcommit = self.repo.head.commit
                commit_str = time.strftime(
                    "%a, %d %b %y %h:%m", time.gmtime(headcommit.committed_date)
                )
                author_str = time.strftime(
                    "%a, %d %b %y %h:%m", time.gmtime(headcommit.authored_date)
                )
                msg = f"{bcolors.OKCYAN}Commit info {headcommit.hexsha} {headcommit.author.name} {commit_str} {author_str}{bcolors.ENDC}"
                logger.info(msg)
                self.logs.append(msg)
            except Exception as error:
                msg = f"{bcolors.FAIL}Git head issue: {self.root} Heads: {self.repo.heads} remotes: {[r.name for r in self.remotes_matched]}{bcolors.ENDC}"
                logger.error(msg)
                self.logs.append( msg)
                #  raise error
                #  continue

            logger.info(f"Repo Branches: {[b.name for b in self.repo.heads]}")
            self.logs.append(f"Repo Branches: {[b.name for b in self.repo.heads]}")
            for remote in self.remotes_matched:
                msg = f"Remote: {remote.name} -[mapped to]-> {remote.url}. Remote Refs/Branches: {[b.name for b in remote.refs]}"
                logger.info(msg)
                self.logs.append(msg)

                do_fetch = True
                if self.assess_only:
                    logger.debug(f"Assess only: {self.assess_only} Skipping fetch")
                    do_fetch = False
                    # continue

                if not check_remote_url(remote.url, self.url):
                    logger.debug(f"Check remote url {self.url} != {remote.url} Skipping fetch as not requested")
                    do_fetch = False
                    # continue

                if do_fetch:
                    self.repo_fetch(remote)

                # self.compares = []
                for repo_branch in self.repo.heads:
                    for remote_refs in remote.refs:
                        remote_branch = remote_refs.name
                        if remote_branch.find(repo_branch.name) >= 0:
                            try:
                                behind_commits = list(
                                    self.repo.iter_commits(
                                        f"{repo_branch.name}..{remote.name}/{repo_branch.name}"
                                    )
                                )
                                ahead_commits = list(
                                    self.repo.iter_commits(
                                        f"{remote.name}/{repo_branch.name}..{repo_branch.name}"
                                    )
                                )
                                compare = Compare(
                                    branch_name=repo_branch.name,
                                    ref_name=remote.name,
                                    ahead_commits=ahead_commits,
                                    behind_commits=behind_commits,
                                    should_pull=False, should_push=False
                                )
                            except GitCommandError as error:
                                msg = f"{bcolors.FAIL}Cannot calculate the remote reference Error: '{error}'{bcolors.ENDC}"
                                logger.error(msg)
                                self.logs.append( msg)
                                compare = Compare(
                                    ahead_commits=[],
                                    behind_commits=[],
                                    should_pull=False, should_push=False
                                )

                            self.compares.append(compare)
                            logger.info(f"Compares: {self.compares}")

                            self.repo_diff_calculation(repo_branch, remote_branch)

                            self.repo_push_pull_calculation(remote)

                # logger.info("")
                # self.logs.append("")
        # return self.logs

    def repo_fetch(self, remote):
        try:
            logger.info(f"fetching remote (Timeout {self.fetch_timeout} Secs) {remote.name} - {remote.url}")
            fetch_results = remote.fetch(kill_after_timeout=self.fetch_timeout)
            logger.debug(f"fetched remotes {remote.name} - {remote.url}")
            self.logs.append(f"fetched remotes")
        except GitCommandError as error:
            msg = f"{bcolors.FAIL} unable to fetch remote {remote} {error}{bcolors.ENDC}"
            logger.error(msg)
            self.logs.append(msg)

    def repo_diff_calculation(self, repo_branch, remote_branch):
        behind_string = (
            f"{bcolors.OKGREEN}{len(self.compares[-1].behind_commits)}{bcolors.ENDC}"
        )
        if len(self.compares[-1].behind_commits) > 0:
            behind_string = (
                f"{bcolors.WARNING}{len(self.compares[-1].behind_commits)}{bcolors.ENDC}"
            )
        ahead_string = (
            f"{bcolors.OKGREEN}{len(self.compares[-1].ahead_commits)}{bcolors.ENDC}"
        )
        if len(self.compares[-1].ahead_commits) > 0:
            ahead_string = (
                f"{bcolors.WARNING}{len(self.compares[-1].ahead_commits)}{bcolors.ENDC}"
            )
        report_msg = f"Behind-{behind_string} Ahead-{ahead_string}. Branch mapping local -> remote: {repo_branch} -> {remote_branch} "
        logger.info(report_msg)
        self.logs.append(report_msg)

    def repo_push_pull_calculation(self, remote):
        if len(self.compares[-1].behind_commits) == 0 and len(self.compares[-1].ahead_commits) > 0:
            self.compares[-1].should_push = True
            if self.push:
                pushinfolist = remote.push()
                for pushinfo in pushinfolist:
                    push_msg = f"{bcolors.OKGREEN}Pushing to remote {pushinfo.summary} was at {pushinfo.old_commit}{bcolors.ENDC}"
                    logger.info(push_msg)
                    self.logs.append(push_msg)
            else:
                push_warning_msg = f"{bcolors.WARNING}Would be useful to push append '--push' to the call{bcolors.ENDC}"
                logger.warning(push_warning_msg)
                self.logs.append(push_warning_msg)
        if len(self.compares[-1].behind_commits) > 0 and len(self.compares[-1].ahead_commits) == 0:
            self.compares[-1].should_pull = True
            if self.pull:
                pullinfolist = remote.pull()
                for pullinfo in pullinfolist:
                    msg = f"{bcolors.OKGREEN}Pulling to remote {pullinfo.summary} was at {pullinfo.old_commit}{bcolors.ENDC}"
                    logger.info(msg)
                    self.logs.append(msg)
            else:
                push_warning_msg = f"{bcolors.WARNING}Would be useful to pull append '--pull' to the call{bcolors.ENDC}"
                logger.warning(push_warning_msg)
                self.logs.append(push_warning_msg)
