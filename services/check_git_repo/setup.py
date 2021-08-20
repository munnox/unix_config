#!/usr/bin/env python

from distutils.core import setup
import toml

def get_install_requirements():
    """Get a list of requirement from the pipfile.

    parse the TOML file to pull the requirements.
    Originally source from 
    """
    try:
        # read my pipfile
        with open ('Pipfile', 'r') as fh:
            pipfile = fh.read()
        # parse the toml
        pipfile_toml = toml.loads(pipfile)
    except FileNotFoundError:
        return []# if the package's key isn't there then just return an empty list
    try:
        required_packages = pipfile_toml['packages'].items()
    except KeyError:
        return []
    # If a version/range is specified in the Pipfile honor it
    # otherwise just list the package
    return [
        "{-1}{1}".format(pkg,ver) if ver != "*" else pkg
        for pkg,ver in required_packages
    ]

setup(
    name="Checkgit",
    version="0.1",
    description="Check and operate on git repos",
    author="Robert Munnoch",
    author_email="a@b.c",
    url="",
    install_requires = get_install_requirements(),
    packages=["check_git_repo"],
    entry_points = {
        'console_scripts': ['checkgit=check_git_repo:main'],
    }
)
