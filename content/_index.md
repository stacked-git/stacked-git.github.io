+++
title = "Stacked Git"
+++

> Stacked Git, **StGit** for short, is an application for managing Git
> commits as a stack of patches.
>
> With a *patch stack* workflow, multiple patches can be developed
> concurrently and efficiently, with each patch focused on a single
> concern, resulting in both a clean Git commit history and improved
> productivity.

The [`stg`](man/stg) command line tool provides commands to quickly and
safely manage a stack of patches.

- Apply and unapplied patches from the stack using
  [`push`](man/stg-push), [`pop`](man/stg-pop), and
  [`goto`](man/stg-goto).
- Incorporate changes from the working tree into a patch and edit patch
  metadata using [`refresh`](man/stg-refresh) and
  [`edit`](man/stg-edit).
- Create and delete patches on the stack using [`new`](man/stg-new),
  [`delete`](man/stg-delete), and [`clean`](man/stg-clean).
- See information about the stack or individual patches using
  [`series`](man/stg-series) and [`show`](man/stg-show).
- Migrate patches to regular commits and *vice versa* using
  [`commit`](man/stg-commit) and [`uncommit`](man/stg-uncommit).

Patch-stack management operations are performed using Git commands and
the patches are stored as Git commit objects, allowing easy merging of
the StGit patches into other repositories using standard Git
functionality.

StGit is licensed under the GNU General Public License, version 2.

## News

### 2022-11-21: [StGit v2.0.3][v2.0.3] has been released.

This release includes a few minor bug fixes and lots of spelling
corrections.

### 2022-11-17: [StGit v2.0.2][v2.0.2] has been released.

This release further improves support for sparse checkout with partial
clone and worktrees. A few documentation improvements are also included.

### 2022-11-07: [StGit v2.0.1][v2.0.1] has been released.

This bugfix release addresses pathological documentation build
performance issues that should improve the downstream packaging
experience.

See the [changelog](changelog/) for all the details on this release.

### 2022-11-06: [StGit v2.0.0][v2.0.0] has been released.

This major release of StGit brings improved performance, several new
features, and many refinements compared to StGit 1.x. It is recommended
that all StGit users upgrade to 2.0.0.

Many thanks to all the StGit users who took the time and effort to try
out the many alpha, beta, and release candidate releases leading up to
this final 2.0.0 release. Lots of issues, big and small, were worked out
from this effort to make this a high-confidence release.

The [changelog](changelog/) has the details of the many changes, but
some highlights include:

- Performance improvements across the board. This is largely due to
  StGit 2.0.0 being reimplemented in [Rust][rust-lang], thus eliminating
  many overheads inherent to the Python interpreter, but also due to
  direct accessing the git repository's object database using
  [libgit2][libgit2] instead of always using `git` subprocesses.
- Refined output and improved error messages. Commands generally produce
  more terse output. Stack modifying operations (`push`, `pop`,
  `refresh`, etc.) use color and sigils to display their outcomes.
- `stg email format` and `stg email send` replace `stg mail`. The new
  commands lean on the battle-hardened `git format-patch` and `git
  send-email` commands, making StGit's email capabilities more robust
  and more standard.
- StGit aliases now behave like Git aliases.
- `stg refresh` gains the `-r`/`--refresh` option, which allows a new
  patch to be created and record changes with one command.

### 2022-09-02: StGit Extension for Visual Studio Code 0.9.0

How cool is this, Samuel Rydh has implemented a StGit extension for
Visual Studio Code! In Samuel's words:

> The extension is closely modelled on the corresponding StGit mode for
> Emacs, which I have been using for years.
>
> There is a bit of learning curve to use the extension since it is
> heavily reliant on operations bound to keyboard shortcuts. The main
> audience is really Emacs users that have started to use VSCode.

See the [extension in the VSCode marketplace][marketplace] or checkout
[the repository on GitHub][vscode-stgit].

[vscode-stgit]: https://github.com/srydh/vscode-stgit
[marketplace]: https://marketplace.visualstudio.com/items?itemName=samuelrydh.stgit

### 2022-01-28: [StGit v1.5][v1.5] has been released.

Several pesky bugs repaired along with some other minor improvements.

Thanks to everyone who submitted a PR or reported an issue!

See the [changelog](changelog/) for all the details on this release.

[v2.0.3]: https://github.com/stacked-git/stgit/releases/tag/v2.0.2
[v2.0.2]: https://github.com/stacked-git/stgit/releases/tag/v2.0.2
[v2.0.1]: https://github.com/stacked-git/stgit/releases/tag/v2.0.1
[v2.0.0]: https://github.com/stacked-git/stgit/releases/tag/v2.0.0
[v1.5]: https://github.com/stacked-git/stgit/releases/tag/v1.5
[rust-lang]: https://www.rust-lang.org/
[libgit2]: https://libgit2.org/

## Why Stacked Git?

The *stack of patches* model is a natural way to maintain a clean Git
history while working on several changes concurrently. A stack-oriented
workflow using StGit can compliment, or even replace, many Git workflows
involving rebase, branches, amended commits, and stashes.

StGit, via the `stg` command line tool, provides commands to quickly and
safely create, push, pop, refresh, and reorder patches.

## Installation

### Dependencies

StGit is written in pure Python with no third-party Python dependencies.
StGit currently supports Python version 3.5 through 3.9. The last
version of StGit to support Python 2 was [v0.23][v0.23].

StGit interoperates closely with Git and does most of its work by
running `git` commands. Git 2.2.0 or newer is required.

### Package Repositories

Recent versions of StGit are available via many package repositories
such as [HomeBrew][pkg-homebrew] and for many Linux distributions
including: [Alpine][pkg-alpine], [Arch][pkg-arch], [Fedora][pkg-fedora],
[Nix][pkg-nix] and [Ubuntu][pkg-ubuntu].

More details about StGit packages availability for various operating
systems can be [found on repology][repology].

[pkg-homebrew]: https://formulae.brew.sh/formula/stgit
[pkg-alpine]: https://pkgs.alpinelinux.org/packages?name=stgit
[pkg-arch]: https://aur.archlinux.org/packages/stgit
[pkg-fedora]: https://src.fedoraproject.org/rpms/stgit
[pkg-nix]: https://nixos.org/nixos/packages.html?attr=gitAndTools.stgit
[pkg-ubuntu]: https://packages.ubuntu.com/source/focal/stgit
[repology]: https://repology.org/project/stgit/versions

### Source Installation

StGit may also be installed from source. Download the [latest
release][gh-latest] or clone from the [StGit repository on
GitHub][gh-repo].

```sh
git clone https://github.com/stacked-git/stgit.git
```

To install from source, choose a `prefix` and:

```sh
make prefix=/usr/local install install-doc
```

For more information about installation, see [the INSTALL.md
file][gh-install].

## Getting Started

This [quick example of using StGit](guides/usage-example/) gives an idea
of a basic StGit workflow using basic commands such as [stg
push](man/stg-push), [stg pop](man/stg-pop), and [stg
refresh](man/stg-refresh).

For a more complete guide to using StGit, [see the
tutorial](guides/tutorial/).

StGit also comes with a complete set of man pages which are [also
available online](man/stg).

## Project Details

[StGit source code][gh-repo] is hosted on GitHub.

### Maintainers

StGit is maintained by Pete Grayson and Catalin Marinas.

### Contributions

Issues and feature requests may be reported on the [StGit issue
tracker][gh-issues].

Pull requests are welcome and may be submitted to the [repo on
GitHub][gh-repo].

See [CONTRIBUTING.md][gh-contributing] for more details about how to
contribute to StGit.

### Mailing List

For questions or discussion, please send email to [the StGit mailing
list](stgit@googlegroups.com). Or use the [Google Groups web
interface][gg-forum].

## Historical

The StGit project was originally hosted at gna.org. That site is no
longer available, but a [snapshot][gna-snapshot] remains available via
the [Wayback Machine](https://web.archive.org/).

## Other Patch Stack Tools

StGit is not the first or only patch stack tool. Both
[Quilt][site-quilt] and Mercurial\'s [mq extension][site-mq] offer
similar interfaces for managing a stack (or \"queue\" or \"series\") of
patches. While Quilt operates on patches outside the context of any
other version control system using GNU diff, the mq extension is part of
the [Mercurial][site-mercurial] version control system.

Similar to mq\'s relationship to Mercurial, StGit is tightly coupled to
Git. StGit keeps its stack metadata as objects in the git repo and
patches themselves are git commits.

## Acknowledgements

Many thanks to Peter Grayson, Karl Wiberg, Yann Dirson, Chuck Lever and
Paolo "Blaisorblade" Giarrusso for their great contribution to the
development of StGit. Many thanks to [all the people who contributed
patches][gh-authors], ideas or reported bugs.

[gg-forum]: https://groups.google.com/d/forum/stgit
[gh-authors]: https://github.com/stacked-git/stgit/blob/master/AUTHORS.md
[gh-contributing]: https://github.com/stacked-git/stgit/blob/master/CONTRIBUTING.md
[gh-install]: https://github.com/stacked-git/stgit/blob/master/INSTALL.md
[gh-issues]: https://github.com/stacked-git/stgit/issues
[gh-latest]: https://github.com/stacked-git/stgit/releases/latest
[gh-repo]: https://github.com/stacked-git/stgit
[gna-snapshot]: https://web.archive.org/web/20170305222727/http://gna.org/projects/stgit/
[site-mercurial]: https://www.mercurial-scm.org/
[site-mq]: https://www.mercurial-scm.org/wiki/MqExtension
[site-quilt]: https://savannah.nongnu.org/projects/quilt/
