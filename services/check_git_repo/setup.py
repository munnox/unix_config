#!/usr/bin/env python

from distutils.core import setup
import setuptools

def get_install_requirements():
    """Get a list of requirement from the pipfile.

    parse the TOML file to pull the requirements.
    Originally source from
    """
    # failing to install package when installing this package
    # TODO having to use the print statement with python setup.py to the setup function
    import toml
    try:
        # read my pipfile
        with open("Pipfile", "r") as fh:
            pipfile = fh.read()
        # parse the toml
        pipfile_toml = toml.loads(pipfile)
    except FileNotFoundError:
        return []  # if the package's key isn't there then just return an empty list
    try:
        required_packages = pipfile_toml["packages"].items()
        required_packages = [(pkg, ver) for pkg, ver in required_packages if not isinstance(ver, dict)] 
        print(required_packages)
    except KeyError:
        return []
    # If a version/range is specified in the Pipfile honor it
    # otherwise just list the package
    required_packages = [
        "{0} {1}".format(pkg, ver) if ver != "*" else pkg
        for pkg, ver in required_packages
    ]
    print(required_packages)
    return required_packages


setup(
    name="Checkgit",
    version="0.1",
    description="Check and operate on git repos",
    author="Robert Munnoch",
    author_email="a@b.c",
    url="",
    # TODO removed due to TOML import issue and fixed requires from get_install_requirements(),
    install_requires=['toml', 'pyyaml ==5.4.1', 'click ==7.1.2', 'GitPython ==3.1.11'],
    packages=["check_git_repo"],
    entry_points={
        "console_scripts": ["checkgit=main:main"],
    },
)
