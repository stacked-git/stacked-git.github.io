.. title: Stacked Git Homepage
.. hidetitle: true
.. slug: index
.. category:
.. description: stg stgit stacked-git
.. type: text

.. contents::
   :depth: 1

About Stacked Git
=================

Stacked Git, **StGit** for short, is an application for managing Git
commits as a stack of patches.

The `stg`_ command line tool provides commands to quickly and safely
manage a stack of patches.

* `push`_ | `pop`_ | `goto`_ to apply and unapplied patches from the stack.
* `refresh`_ | `edit`_ to incorporate changes from the working tree into a patch
  and edit patch metadata.
* `new`_ | `delete`_ | `clean`_ to create and delete patches on the stack.
* `series`_ | `show`_ to see information about the stack or individual patches.
* `commit`_ | `uncommit`_ to migrate patches to regular commits and *vice
  versa*.

.. _stg: man/stg.html
.. _push: man/stg-push.html
.. _goto: man/stg-goto.html
.. _pop: man/stg-pop.html
.. _refresh: man/stg-refresh.html
.. _edit: man/stg-edit.html
.. _new: man/stg-new.html
.. _delete: man/stg-delete.html
.. _clean: man/stg-clean.html
.. _series: man/stg-series.html
.. _show: man/stg-show.html
.. _commit: man/stg-commit.html
.. _uncommit: man/stg-uncommit.html

Patch-stack management operations are performed using Git commands and
the patches are stored as Git commit objects, allowing easy merging of
the StGit patches into other repositories using standard Git
functionality.

StGit is licensed under the GNU General Public License, version 2.

Why Stacked Git?
----------------

The *stack of patches* model is a natural way to maintain a clean Git
history while working on several changes concurrently. A stack-oriented
workflow using StGit can compliment, or even replace, many Git workflows
involving rebase, branches, ammended commits, and stashes.

StGit, via the ``stg`` command line tool, provides commands to quickly
and safely create, push, pop, refresh, and reorder patches.

Installation
============

Dependencies
------------

StGit is written in pure Python with no third-party Python dependencies.
StGit currently supports Python version 2.6, 2.7, 3.4, 3.5, 3.6, 3.7,
and 3.8, although support for Python 2 will be dropped in a future
release.

StGit interoperates closely with Git and does most of its work by
running ``git`` commands. Git 2.2.0 or newer is required.

Package Repositories
--------------------

Recent versions of StGit are available via many package repositories
such as `HomeBrew`_ and for many Linux distributions including:
`Alpine`_, `Arch`_, `Fedora`_, `Nix`_ and `Ubuntu`_.

More details about StGit packages availability for various operating
systems can be `found on repology`_.

.. _HomeBrew: https://formulae.brew.sh/formula/stgit
.. _Alpine: https://pkgs.alpinelinux.org/packages?name=stgit
.. _Arch: https://aur.archlinux.org/packages/stgit
.. _Fedora: https://src.fedoraproject.org/rpms/stgit
.. _Nix: https://nixos.org/nixos/packages.html?attr=gitAndTools.stgit
.. _Ubuntu: https://packages.ubuntu.com/source/focal/stgit
.. _found on repology: https://repology.org/project/stgit/versions

Source Installation
-------------------

StGit may also be installed from source. Download the `latest release`_
or clone from the `StGit repository on GitHub`_.

.. code:: console

   $ git clone https://github.com/stacked-git/stgit.git

To install from source, choose a ``prefix`` and:

.. code:: console

   $ make prefix=/usr/local install install-doc

For more information about installation, see `the INSTALL file`_.

.. _latest release: https://github.com/stacked-git/stgit/releases/latest
.. _StGit repository on GitHub: https://github.com/stacked-git/stgit
.. _the INSTALL file: https://github.com/stacked-git/stgit/blob/master/INSTALL

Getting Started
===============

This `quick example of using StGit <usage-example.html>`_ gives an idea
of a basic StGit workflow using basic commands such as
`stg push`_, `stg pop`_, and `stg refresh`_.

For a more complete guide to using StGit, `see the tutorial
<man/tutorial.html>`_.

StGit also comes with a complete set of man pages which are `also
available online <man/stg.html>`_.

.. _stg push: man/stg-push.html
.. _stg pop: man/stg-pop.html
.. _stg refresh: man/stg-refresh.html

Project Details
===============

StGit source code is hosted on GitHub.

Maintainers
-----------

StGit is maintained by Pete Grayson and Catalin Marinas.

Contributions
-------------

Issues and feature requests may be reported on the `StGit issue
tracker`_.

Pull requests are welcome and may be submitted to the `repo on GitHub`_.

.. _StGit issue tracker: https://github.com/stacked-git/stgit/issues
.. _repo on GitHub: https://github.com/stacked-git/stgit

Mailing List
------------

For questions or discussion, please send email to `the StGit mailing
list`_. Or use the `Google Groups web interface`_.

.. _the StGit mailing list: stgit@googlegroups.com
.. _Google Groups web interface: https://groups.google.com/d/forum/stgit

Historical
----------

The StGit project was originally hosted at gna.org. That site is no
longer available, but a `snapshot`_ remains available via the `Wayback
Machine`_.

.. _snapshot: https://web.archive.org/web/20170305222727/http://gna.org/projects/stgit/
.. _Wayback Machine: https://web.archive.org/

Other Patch Stack Tools
-----------------------

StGit is not the first or only patch stack tool. Both `Quilt`_ and
Mercurial's `mq extension`_ offer similar interfaces for managing a
stack (or "queue" or "series") of patches. While Quilt operates on
patches outside the context of any other version control system using
GNU diff, the mq extension is part of the `Mercurial`_ version control
system.

Similar to mq's relationship to Mercurial, StGit is tightly coupled to
Git. StGit

.. _Quilt: https://savannah.nongnu.org/projects/quilt/
.. _mq extension: https://www.mercurial-scm.org/wiki/MqExtension
.. _Mercurial: https://www.mercurial-scm.org/

Acknowledgements
----------------

Many thanks to Peter Grayson, Karl Wiberg, Yann Dirson, Chuck Lever and
Paolo Blaisorblade Giarrusso for their great contribution to the
development of StGit. Many thanks to all the people who contributed
patches, ideas or reported bugs.
