+++
title = "Stacked Git"
+++

> Stacked Git, **StGit** for short, is an application for managing Git
> commits as a stack of patches.
>
> With a _patch stack_ workflow, multiple patches can be developed
> concurrently and efficiently, with each patch focused on a single
> concern, resulting in both a clean Git commit history and improved
> productivity.

The [`stg`](man/stg) command line tool provides commands to quickly and
safely manage a stack of patches.

- Apply and unapply patches from the stack using
  [`push`](man/stg-push), [`pop`](man/stg-pop), and
  [`goto`](man/stg-goto).
- Incorporate changes from the working tree into a patch and edit patch
  metadata using [`refresh`](man/stg-refresh) and
  [`edit`](man/stg-edit).
- Create and delete patches on the stack using [`new`](man/stg-new),
  [`delete`](man/stg-delete), and [`clean`](man/stg-clean).
- See information about the stack or individual patches using
  [`series`](man/stg-series) and [`show`](man/stg-show).
- Migrate patches to regular commits and _vice versa_ using
  [`commit`](man/stg-commit) and [`uncommit`](man/stg-uncommit).

Patch-stack management operations are performed using Git commands and
the patches are stored as Git commit objects, allowing easy merging of
the StGit patches into other repositories using standard Git
functionality.

StGit is licensed under the GNU General Public License, version 2.

## News

### 2024-05-05: [StGit v2.4.7][v2.4.7] has been released.

### 2024-04-07: [StGit v2.4.6][v2.4.6] has been released.

### 2024-02-18: [StGit v2.4.5][v2.4.5] has been released.

### 2024-02-11: [StGit v2.4.4][v2.4.4] has been released.

### 2024-02-04: [StGit v2.4.3][v2.4.3] has been released.

Fixes finding global config and running an interactive editor on
Windows.

Also enables `stg branch --delete` to operate on the current branch.

### 2023-10-08: [StGit v2.4.0][v2.4.0] has been released.

This release adds some new command line options to `stg branch`, `stg
sink`, and `stg delete`.

### 2023-10-04: [StGit v2.3.3][v2.3.3] has been released.

Fixes to zsh completions along with MacOS portability improvements.

### 2023-08-19: [StGit v2.3.2][v2.3.2] has been released.

This release contains some improvements to `stg uncommit` along with
updated dependencies.

### 2023-07-25: [StGit v2.3.1][v2.3.1] has been released.

This release contains a few minor bug fixes and updated dependencies.

### 2023-05-25: [StGit v2.3.0][v2.3.0] has been released.

The headline feature for this release is prebuilt StGit packages for
various platforms. Unofficial deb and rpm packages containing a
statically linked `stg` executable should help solve the problem of how
to deploy a modern version of StGit on distributions using deb and rpm
packages. And a shiny new msi package makes StGit natively deployable on
Windows without requiring users to build it themselves.

This release gets a minor bump because the `import-compressed` feature
has been removed in favor of always-on support for importing compressed
patches and tarball series. Part of this change was switching from the
bzip2 crate, which depends on the system libbz2, to the pure-Rust
bzip2-rs crate which allows for static linking when not using the
`import-url` feature.

This release also contains a few more bugfixes to `stg import`.

[v2.4.7]: https://github.com/stacked-git/stgit/releases/tag/v2.4.7
[v2.4.6]: https://github.com/stacked-git/stgit/releases/tag/v2.4.6
[v2.4.5]: https://github.com/stacked-git/stgit/releases/tag/v2.4.5
[v2.4.4]: https://github.com/stacked-git/stgit/releases/tag/v2.4.4
[v2.4.3]: https://github.com/stacked-git/stgit/releases/tag/v2.4.3
[v2.4.0]: https://github.com/stacked-git/stgit/releases/tag/v2.4.0
[v2.3.3]: https://github.com/stacked-git/stgit/releases/tag/v2.3.3
[v2.3.2]: https://github.com/stacked-git/stgit/releases/tag/v2.3.2
[v2.3.1]: https://github.com/stacked-git/stgit/releases/tag/v2.3.1
[v2.3.0]: https://github.com/stacked-git/stgit/releases/tag/v2.3.0

{{< details "More StGit News..." >}}

### 2023-05-15: [StGit v2.2.4][v2.2.4] has been released.

StGit regained the ability to upgrade from stacks created by very old
versions of StGit. This includes, for example, stacks created with StGit
v0.19 which is (unfortunately) what is still shipped by Debian/Ubuntu
and their derivatives.

Also included are fixes for regressions affecting branch creation and
patch import.

### 2023-04-26: [StGit v2.2.3][v2.2.3] has been released.

StGit is repaired to work on Windows once more.

### 2023-04-01: [StGit v2.2.2][v2.2.2] has been released.

This release addresses a bug that broke rebasing to a ref containing a
'@' character.

### 2023-03-29: [StGit v2.2.1][v2.2.1] has been released.

This bugfix release addresses regressions with running StGit in linked
worktrees and with hooks not working when running from a subdirectory of
the work dir. Several other minor issues are also repaired.

See the [changelog](changelog/) for all the details on this release.

### 2023-02-24: [StGit v2.2.0][v2.2.0] has been released.

This release contains several quality of life features, including new
options for specifying patches and branches on the command line. And
improved performance.

#### Patch Locator Syntax

In addition to being able to specify patches by name, StGit now supports
several new alternatives for specifying patches:

- By relative offset from the topmost patch, e.g. `-1`, `+3`, or `~2`.
- By their absolute index in the stack, e.g. `0` or `12`.
- By offset from another patch, e.g. `some-patch~` or `some-patch+2`.
- By relative offset from the last visible patch, e.g. `^` or `^2`.

The new patch locator syntax is detailed in the [`stg`](man/stg) man
page.

#### New Options for `stg series`

To complement the new patch locator syntax, new `-O`/`--offsets` and
`-I/--indices` options display each patch's relative offset from top and
absolute index, respectively.

The new `-r`/`--reverse` option allows the stack to be shown top-side
up. This may produce a more intuitive view of the stack for some StGit
users. Consider adding a `stack` alias using this option, for example
with `git config --global stgit.alias.stack 'series -rOP'`.

Speaking of aliases, now each of the "Display Options" for `stg series`
have a `--no-xxx` variant. These can be helpful for masking options used
in series aliases. For example, the `stack` offset suggested above could
be run as `stg stack --no-offsets` to disable display of offsets.

Finally, the `--short` option now takes an optional integer value to
specify the number of patches to show.

#### Branch Locators

StGit now supports specifying a branch using the same `@{-<n>}` syntax
supported by `git`. This enables, for example, switching to the
previously checked-out branch with `stg branch @{-1}` or just `stg branch -`
(where `-` is synonymous with `@{-1}`).

#### Command Line Options

The `--signoff` option now has a short variant `-s`. This is a breaking
change. The `--submodules` no longer has a `-s` short option. Similarly,
the `--series` options for `stg import`, `stg float`, and `stg sync` now
use `-S` instead of `-s` for their short variants.

#### Gitoxide

StGit now uses [Gitoxide][gitoxide] (gix crate) instead of libgit2 (git2
crate) as its git access library. In addition to being a pure-Rust
dependency, gitoxide has considerably less startup overhead (4x) than
git2. This has a big impact on the latency of StGit commands.

See the [changelog](changelog/) for more details on this release.

### 2023-01-16: Blog Post: [How I Keep Using Stacked Git at $WORK][stgit-at-work2]

[This blog post][stgit-at-work2] from lthms describes their
single-branch workflow using StGit and is a follow-on to their [first
blog post about StGit][stgit-at-work].

### 2022-12-12: [StGit v2.1.0][v2.1.0] has been released.

This minor release introduces several long-awaited features, including
some potentially breaking changes.

The main breaking feature is relaxed stack initialization. Instead of
needing to explicitly initialize a StGit stack on a branch, patch
creating commands such as `stg new` and `stg import` will automatically
initialize the stack, if needed. Most other commands that previously
required an initialized stack will now operate as if there is an empty
stack if the stack is not yet initialized.

Another potentially breaking change is that the `stgit.gpgsign`
configuration variable is now independent of `commit.gpgsign`. I.e. to
have signed stack metadata commits, `stgit.gpgsign` must be set to
`true`.

See the [changelog](changelog/) for all the details on this release.

### 2022-11-30: [StGit v2.0.4][v2.0.4] has been released.

This release makes some repairs to aliases, including documenting
aliases along with all other StGit configuration variables.

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
  commands lean on the battle-hardened `git format-patch` and
  `git send-email` commands, making StGit's email capabilities more
  robust and more standard.
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
[stgit-at-work2]: https://soap.coffee/~lthms/opinions/StackedGit2.html
[stgit-at-work]: https://soap.coffee/~lthms/opinions/StackedGit.html
[v2.2.4]: https://github.com/stacked-git/stgit/releases/tag/v2.2.4
[v2.2.3]: https://github.com/stacked-git/stgit/releases/tag/v2.2.3
[v2.2.2]: https://github.com/stacked-git/stgit/releases/tag/v2.2.2
[v2.2.1]: https://github.com/stacked-git/stgit/releases/tag/v2.2.1
[v2.2.0]: https://github.com/stacked-git/stgit/releases/tag/v2.2.0
[v2.1.0]: https://github.com/stacked-git/stgit/releases/tag/v2.1.0
[v2.0.4]: https://github.com/stacked-git/stgit/releases/tag/v2.0.4
[v2.0.3]: https://github.com/stacked-git/stgit/releases/tag/v2.0.3
[v2.0.2]: https://github.com/stacked-git/stgit/releases/tag/v2.0.2
[v2.0.1]: https://github.com/stacked-git/stgit/releases/tag/v2.0.1
[v2.0.0]: https://github.com/stacked-git/stgit/releases/tag/v2.0.0
[rust-lang]: https://www.rust-lang.org/
[libgit2]: https://libgit2.org/
[gitoxide]: https://github.com/Byron/gitoxide

{{< /details >}}

## Why Stacked Git?

The _stack of patches_ model is a natural way to maintain a clean Git
history while working on several changes concurrently. A stack-oriented
workflow using StGit can compliment, or even replace, many Git workflows
involving rebase, branches, amended commits, and stashes.

StGit, via the `stg` command line tool, provides commands to quickly and
safely create, push, pop, refresh, and reorder patches.

## Installation

### Dependencies

StGit interoperates closely with Git and does much of its work by
running `git` commands. Git 2.2.0 or newer is required.

StGit was originally implemented in Python, but as of version 2.0.0,
StGit is implemented in [Rust](https://www.rust-lang.org/). See
[INSTALL.md][gh-install] for more details on StGit's source and runtime
dependencies.

### Package Repositories

Recent versions of StGit are available in several package repositories
such as [HomeBrew][pkg-homebrew] and [MacPorts][pkg-macports] for MacOS
and for the [Arch][pkg-arch] and [Gentoo][pkg-gentoo] Linux
distributions. StGit is also available via [crates.io][pkg-crate],
[guix][pkg-guix], and [nix][pkg-nix].

More details about StGit packages availability for various operating
systems can be [found on repology][repology].

[pkg-homebrew]: https://formulae.brew.sh/formula/stgit
[pkg-macports]: https://ports.macports.org/port/stgit/
[pkg-arch]: https://aur.archlinux.org/packages/stgit
[pkg-gentoo]: https://packages.gentoo.org/packages/dev-vcs/stgit
[pkg-crate]: https://crates.io/crates/stgit
[pkg-guix]: https://packages.guix.gnu.org/packages/stgit/
[pkg-nix]: https://search.nixos.org/packages?type=packages&query=stgit
[repology]: https://repology.org/project/stgit/versions

### Prebuilt Packages

Prebuilt deb, rpm, and msi packages are provided by the StGit project.
Packages for the latest release may be found [here][gh-latest].

Note that the Linux deb and rpm packages are unofficial. The upstream
Debian and RedHat/Fedora projects currently only publish outdated
versions of StGit (see [repology][repology]). These unofficial packages
are meant to be a stop-gap until official StGit packages are provided by
downstream distributions.

The Linux deb and rpm packages are statically linked use musl libc to
maximize compatibility. They should hopefully work on a wide range of
deb and rpm based distributions.

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

For questions or discussion, please post to [StGit's discussions
page][gh-discussions] on GitHub.

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

[gh-authors]: https://github.com/stacked-git/stgit/blob/master/AUTHORS.md
[gh-contributing]: https://github.com/stacked-git/stgit/blob/master/CONTRIBUTING.md
[gh-discussions]: https://github.com/stacked-git/stgit/discussions
[gh-install]: https://github.com/stacked-git/stgit/blob/master/INSTALL.md
[gh-issues]: https://github.com/stacked-git/stgit/issues
[gh-latest]: https://github.com/stacked-git/stgit/releases/latest
[gh-repo]: https://github.com/stacked-git/stgit
[gna-snapshot]: https://web.archive.org/web/20170305222727/http://gna.org/projects/stgit/
[site-mercurial]: https://www.mercurial-scm.org/
[site-mq]: https://www.mercurial-scm.org/wiki/MqExtension
[site-quilt]: https://savannah.nongnu.org/projects/quilt/
