import check_git_repo
import click
import sys
import logging
import traceback, sys
import yaml

logger = logging.getLogger(__name__)


@click.command()
#  @click.option('--count', default=1, help='Number of greetings.')
@click.option(
    "--path", prompt="Enter path", help="Enter the path to the repo dir", default="."
)
@click.option(
    "--url", prompt="Enter url to push", help="Enter the url to the push", default=""
)
@click.option("--assess_only", is_flag=True, default=False)
@click.option("--push", is_flag=True, default=False)
@click.option("--pull", is_flag=True, default=False)
def main(path, url, assess_only, push, pull):
    """Simple program to find git repos within a given path."""
    logging.basicConfig(
        # format="%(asctime)s %(levelname)s:%(name)s: %(message)s",
        format="%(levelname)-8s|%(name)s|%(filename)-5s:%(lineno)-4d|%(funcName)s(%(processName)s)> %(message)s",
        level=logging.DEBUG,
        datefmt="%H:%M:%S",
        stream=sys.stderr,
    )
    logging.getLogger("git.cmd").setLevel(logging.INFO)
    logs = []
    full_path = check_git_repo.get_local_path(path)
    click.echo(f"Running git repo checker in {full_path}")
    repos_to_process = check_git_repo.get_git_list(full_path)
    repos = [repo for repo in repos_to_process if repo["git"]]

    repo_string = "\n".join([f"* {repo['root']}" for repo in repos])
    logs.append(
        f"Repositories to process ({len(repos)}:{len(repos_to_process)}): {repo_string}\n"
    )
    log_str = "\n".join(logs)
    logger.info(log_str)
    logs.append(log_str)
    # Process the repos in order
    assessors = []
    for repo in repos_to_process:
        if repo["git"]:
            try:
                assessor = check_git_repo.RepoAssessor(repo['root'], url, assess_only, push, pull)
                assessor.process_repo()
                assessors.append(assessor)
                # local_logs = check_git_repo.process_repo(
                #     repo["root"], url, assess_only, push, pull
                # )
                # log_str = "\n".join(local_logs)
                # logger.info(log_str)
                # logs += assessor.logs
                # logs += [repr(assessor.get_dict_summary())]
            except Exception as error:
                click.echo(
                    f"{check_git_repo.bcolors.FAIL}Error found on {repo['root']} : {type(error)} - {error}\n{traceback.format_exc()}{check_git_repo.bcolors.ENDC}"
                )
    # Join the logs from the repo
    log_str = "\n".join(logs)
    click.echo(log_str)

    roots = [r['root'] for r in repos_to_process if r['git'] ]
    assessments = [a.get_dict_summary() for a in assessors]
    assessments_dict = {
        a['root']: a
        for a in assessments
    }
    # roots = {
    #     r: assessments_dict[r]
    #     for r in roots
    # }
    with open("result.yaml", "w") as fh:
        fh.write(
            yaml.dump(
                {
                    "repos": roots,
                    "assessment": assessments_dict,
                },
                width=50,
                indent=2,
                canonical=False,
                default_flow_style=False,
            )
        )


if __name__ == "__main__":
    main()
