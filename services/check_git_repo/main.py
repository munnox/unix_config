import check_git_repo
import click


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
    logs = []
    full_path = check_git_repo.get_local_path(path)
    click.echo(f"Running git repo checker in {full_path}")
    repos_to_process = check_git_repo.get_git_list(full_path)
    repos = [repo for repo in repos_to_process if repo["git"]]

    repo_string = "\n".join([f"* {repo['root']}" for repo in repos])
    logs.append(
        f"Repositories to process ({len(repos)}:{len(repos_to_process)}): {repo_string}\n"
    )
    # Process the repos in order
    for repo in repos_to_process:
        if repo["git"]:
            try:
                logs += check_git_repo.process_repo(
                    repo["root"], url, assess_only, push, pull
                )
            except Exception as error:
                click.echo(f"Error found on {repo['root']} : {type(error)} - {error}")
    # Join the logs from the repo
    log_str = "\n".join(logs)
    click.echo(log_str)


if __name__ == "__main__":
    main()
