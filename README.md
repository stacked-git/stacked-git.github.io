# Source for stacked-git.github.io

This is the code and content for the website
https://stacked-git.github.io

The source for the website is found in this `src` branch.

The generated files for the website are deployed to the `master` branch.

## Prerequisites

The site is generated using Hugo, https://gohugo.io.

The `asciidoc` package must also be installed. It is used to generate
html man pages from the asciidoc source files.

## Sync with stgit repo

The man page and changelog content of the website come from a peer stgit
repository.

The asciidoc man page files (`stg*.txt`) are copied into the working
tree of this repository along with the `command-list.txt` file.

Set `STGIT_WORKTREE` to point at the peer `stgit` repo if it is
somewhere other than `../stgit`.

``` shellsession
$ make sync
```

## Serve locally

Hugo can serve the website locally for development purposes:

``` shellsession
$ hugo serve
```

## Build

To build the static site, just invoke `hugo`:

``` shellsession
$ hugo
```

The site generated in the `public` directory.

## Deploy

The generated site is deployed by updating the `master` branch with the
generated site files found in the `public` directory, and pushing to the
remote GitHub respository's `master` branch.

Pushing `src` branch changes to the GitHub repository will trigger a
GitHub Action that will publish to the `master` branch as described
above.

N.B. The `src` needs to be manually pushed to the upstream GitHub repo's
`src` branch.
