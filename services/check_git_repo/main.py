import os
import click

#  https://gitpython.readthedocs.io/en/stable/tutorial.html
from git import Repo

class bcolors:
    """console colors

    Source https://stackoverflow.com/questions/287871/how-to-print-colored-text-in-python
    """
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def process_repo(root, url, push):
    repo = Repo(root)
    assert not repo.bare

    remotes_matched = []
    for remote in repo.remotes:
        if remote.url.find(url) >= 0:
            #  for repo_branch in repo.heads:
            remotes_matched.append(remote)
    logs = []
    if len(remotes_matched) > 0:
        logs.append(f"{bcolors.HEADER}remote: {root}{bcolors.ENDC}")
        logs.append(f"Repo Branches: {[b.name for b in repo.heads]}")
        for remote in remotes_matched:
            logs.append(f"Remotes: {remote.name} = {remote.url}")
            logs.append(f"Remote Refs: {[b.name for b in remote.refs]}")
            fetch_results = remote.fetch()
            logs.append(f"fetching remotes")
            for repo_branch in repo.heads:
                #  print(f"repo_branch: {repo_branch}")
                for remote_refs in remote.refs:
                    remote_branch = remote_refs.name
                    if remote_branch.find(repo_branch.name) >= 0:
                        behind_commits = list(repo.iter_commits(f'{repo_branch.name}..{remote.name}/{repo_branch.name}'))
                        ahead_commits = list(repo.iter_commits(f'{remote.name}/{repo_branch.name}..{repo_branch.name}'))
                        logs.append(f"repo_branch: {repo_branch} -> remote_branch: {remote_branch} behind-{len(behind_commits)}  ahead-{len(ahead_commits)}")
                        if len(behind_commits) == 0 and len(ahead_commits) > 0:
                            logs.append(f"{bcolors.WARNING}Would be useful to push{bcolors.ENDC}")
                            if push:
                                pushinfolist = remote.push() 
                                for pushinfo in pushinfolist:
                                    logs.append(f"Pushing to remote {pushinfo.summary} was at {pushinfo.old_commit}")
            logs.append("")
    return logs

@click.command()
#  @click.option('--count', default=1, help='Number of greetings.')
@click.option("--path", prompt="Enter path", help="Enter the path to the repo dir")
@click.option("--url", prompt="Enter url to push", help="Enter the url to the push")
@click.option('--push', is_flag=True, default=False)
def main(path, url, push):
    """Simple program to find git repos within a given path."""
    logs = []
    for root, dirs, files in os.walk(path, topdown=False):
        #  for name in files:
        #      print(os.path.join(root, name))
        if ".git" in dirs:
            #  print(f"git directory found: {root}")
            logs += process_repo(root, url, push)
        #  for name in dirs:
        #      print(os.path.join(root, name))
    log_str = "\n".join(logs)
    print(log_str)  

if __name__ == "__main__":
    main()
