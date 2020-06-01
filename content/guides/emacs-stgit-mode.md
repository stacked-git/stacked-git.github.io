+++
title = "Emacs stgit-mode Guide"
+++

StGit comes with an Emacs mode, `stgit-mode`, supporting Emacs versions
22 and later.

To start using it, add the `stgit/contrib` directory to your Emacs
load-path and run `(require 'stgit)`. For example, you can add the
following to your `.emacs` file:

```
(add-to-list 'load-path "/path/to/stgit/contrib")
(require 'stgit)
```

Start `stgit-mode` using `M-x stgit` and select the directory where the
source code you want to use StGit on can be found. If StGit has not been
initialized in this directory yet, you will need to run +M-x stgit-init+
before you continue.

The `stgit-mode` buffer (usually named `*stgit*`) has the following
layout:

```
Branch: name-of-branch

+ The first applied patch
+ Another applied patch
> The topmost patch
  Index
    <no files>
  Work Tree
    <no files>
- An unapplied patch
- Another unapplied patch
--
```

The above means that the active branch name is `name-of-branch` and it
contains five patches, three of which are applied. The git index and
working tree contain no (modified) files.

## Basic Commands

To get help, press `h`. This opens a new buffer which lists all commands
supported in `stgit-mode`. Also, if you have the menu bar enabled
(toggled using `M-x menu-bar-mode`), a new menu entry called `StGit`
will appear, from which you can run several StGit commands. As the menu
should be self-explanatory, the rest of this tutorial will focus on
available keyboard commands.

Move the point (cursor) between lines using `C-p` and `C-n`, or between
patches using `p` and `n`.

You can [undo](/man/stg-undo) and [redo](/man/stg-redo) StGit commands
using `C-/` and `C-c C-/`, respectively.

## Creating New Patches

If you want to create a new patch, first make some changes that should
go into it. As you save a file which is Git-controlled, it will appear
as a modification in the `Work Tree` section:

```
  Work Tree
    Modified       foo.txt
```

To create a new patch based on the changes in the index or, if it
contains no changes, the working tree, press `c`. This opens a new
buffer where you can enter the patch description. When you are done,
press `C-c C-c`. Your new patch will now show up in the `*stgit*`
buffer, and the working tree will no longer contain any modifications:

```
+ The topmost patch
> First line of your new description
  Index
    <no files>
  Work Tree
    <no files>
```

As you make additional changes in your files, and want to include them
in the topmost patch, press `r`, which runs [stg
refresh](/man/stg-refresh). If you want to add the changes to a patch
which is not topmost, move the point to the line of that patch and press
`C-u r`.

## Inspecting Patches

To see what a particular patch contains, you can move the point (cursor)
to the line of that patch, and press `RET` (Enter). This will "expand"
the patch and show which files it changes:

```
+ My patch
    Modified       foo.txt
    Deleted        bar.c
```

You can press `=`, which will show the diff of that patch or file in a
new buffer. With a prefix argument (`C-u =`), the diff will not show
changes in whitespace.

To visit (open) a modified file in another Emacs window, press `o` on
that line. `RET` will visit it in the current window.

## Changing the Patch Series

You can [push](/man/stg-push) and [pop](/man/stg-pop) patches using `>`
(pushes the topmost unapplied patch onto the stack) and `<` (pops the
topmost applied patch off the stack).

By moving the point to a particular patch and pressing `P` (`S-p`) you
either (if it already was applied) pop that patch off the stack, or (if
it was unapplied) push it onto the stack.

You can move patches by first marking one or more using `m`. Then, move
the point to where in the series you want these patches to move, and
press `M`. Use `DEL` or `u` to remove a mark.

You can also combine ([squash](/man/stg-squash)) two or more patches by
marking them and pressing `S` (`S-s`). This will open a new buffer where
you can edit the patch description of the new, combined, patch. When
done, press `C-c C-c`, and the topmost of the marked patches will be
replaced in the stack by one combined patch.

You can [delete](/man/stg-delete) a patch by moving to its line and
pressing `D`. If you press `C-u D`, the contents of the patch will be
spilled to the index.

To [edit](/man/stg-edit) the description of a patch, press `e`. This
opens the patch description in a new buffer. Press `C-c C-c` when you
are done editing the patch.

These operations may result in merge conflicts; more about that later.

## Patch Names

By default, the patch description is shown but not the patch names. You
can toggle showing the names using `t n`. To rename a patch, press `C-c
C-r`.

## Showing Committed Patches

Sometimes it is convenient to be able to investigate already committed
patches. Toggle showing these using `t h`. With a prefix argument, you
can set how many to show; e.g., `7 t h` will show seven already
committed patches.

## Using the Index and Working Tree

You can move a changed file between the index and the working tree using
`i`. This is useful if your working tree contains a number of changes
and you want to create or refresh a patch using only some of the changed
files. Once you have the correct set of files in the index, use `c` to
create or `r` to refresh patches using only the files in the index.

If you want to revert a change in either the index or the working tree,
move the point to that line and press `U`. If you press `U` on the
`Index` or `Work Tree` lines, all the changes in the index or working
tree will be reverted.

## Branches

You can switch to another [branch](/man/stg-branch) by pressing `B`. If
you type the name of a branch that does not exist, you will be asked
whether to create one. The new branch will be based off the current
`HEAD`.

Use `C-c C-b` to [rebase](/man/stg-rebase) the current branch. It will
default to rebasing to the `git config` setting for
`branch.<branch>.stgit.parentbranch`.

## Merge Conflicts

If an operation resulted in a merge conflict, the files with conflicts
will show as `Unmerged` in the `*stgit*` buffer.

To handle the conflicts, you can [undo](/man/stg-undo) the operation
that caused the conflict using `C-u C-/`. Note the `C-u` prefix, which
will tell the undo operation to continue despite the index or working
tree containing changes.

If you instead want to resovle the changes, you must first edit the
files with conflicts to make sure they are in the correct state. Once
you have done this, press `R` on the line of that file, which will
remove the `Unmerged` flag. Once all conflicts have been resolved, you
can continue working as normal, for example by refreshing the patch that
had the conflict.

To investigate the reason of conflicts, you can use the `d b`, `d o`,
and `d t` commands to, respectively, show the diffs against the merge
base, our branch, or their branch. `d c` shows a combined diff. See
[git-diff(1)](https://git-scm.com/docs/git-diff) for more information
about these commands.

A more powerful tool to resolve conflicts is the Emacs `smerge-mode`. To
start using it to resolve a conflict, press `d m`. It is outside the
scope of this tutorial to explain how to use it, but press `q` to leave
`smerge-mode`.
