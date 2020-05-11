# Source for stacked-git.github.io

This is the code and content for the website https://stacked-git.github.io

The source for the website is found in this `src` branch.

The generated files for the website are deployed to the `master` branch.

## Prerequisites

The site is generated using Nikola, https://getnikola.com. It is recommended
to setup a Python virtual environment:

``` shellsession
$ python3 -m venv .py-nikola
$ . .py-nikola/bin/activate
$ pip install --upgrade pip
$ pip install -r requirements.txt
```

The `asciidoc` package must also be installed. It is used to generate html man
pages from the asciidoc source files.

## Build

The man page content of the website comes from a peer stgit repository.

The asciidoc man page files (`stg*.txt`) are copied into the working tree
of this repository. The `asciidoc.conf` and `command-list.txt` files are
also copied from the peer `stgit` repo.

The nikola asciidoc plugin is then responsible for converting the asciidoc
source files into the final html files.

The `Makefile`'s `build` target does all of the above.

Set `STGIT_WORKTREE` to point at the peer `stgit` repo if it is somewhere other
than `../stgit`.

``` shellsession
$ make build
```

## Deploy

The generated site is deployed by updating the `master` branch with the
generated site files found in the output directory, and pushing to the remote
GitHub respository's `master` branch.

The `Makefile`'s `deploy` target automates the process of building the site,
updating and committing the local `master` branch, and pushing to the remote
`master` branch on GitHub.

``` shellsession
$ make deploy
```

N.B. The `src` needs to be manually pushed to the upstream GitHub repo's `src`
branch.
