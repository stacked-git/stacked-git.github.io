+++
title = "Usage Example"
+++

Setup
=====

StGit is used with regular Git repositories. Here we setup a simple Git
repository with two files:

```bash
$ git init myrepo
$ cd myrepo
$ echo "Hello" > hi.txt
$ echo "Goodbye" > bye.txt
$ git add hi.txt bye.txt
$ git commit -m "Initial commit"
```

The `stg init` command is run once to enable use of StGit on a branch,
in this case the `master` branch.

```sh
$ stg init
```

After initializing StGit, new patches may be created. But first, let's
make an edit to one of the files.

```sh
$ echo "Hello world" > hi.txt
$ stg status
 M hi.txt
```

The `stg status` command is just a built-in alias for `git status -s`.

Creating a Patch
================

Now that we have modified `hi.txt`, we can create a new *patch* to
capture the change. We give the patch a name, in this case
`hello-patch`.

StGit patches *are* regular Git commits, so they have a commit message
too. We use the `-m` option with `stg new` to provide a message for the
patch. Like `git commit`, if we do not provide a message on the command
line, we will be prompted to enter a message interactively using our
`$EDITOR`.

A nice thing about StGit patches is that we can easily revise the
message later using `stg edit`. So for now we use a short and simple
message.

```sh
$ stg new -m "Improve greeting" hello-patch
Now at patch "hello-patch"
```

Now that we have created our first patch, we can take a look at the
patch stack using the `stg series` command:

```sh
$ stg series
> hello-patch
```

Creating a new patch with `stg new` does not actually capture any of the
modifications in our working tree to the patch. To incorporate
modifications from the working tree into the current (topmost) patch, we
use `stg refresh`:

```sh
$ stg status
 M hi.txt
$ stg refresh
Now at patch "hello-patch"
$ stg status
```

We can see the contents of a patch using `stg show`:

```sh
$ stg show hello-patch
```

```diff
commit 4ce03d47953f19771ff4e1030a296c4628e43531
Author: Au Thor <author@example.com>
Date:   Wed Jan 1 23:59:00 2020 -0400

    Improve greeting

diff --git a/hi.txt b/hi.txt
index e965047..f75ba05 100644
--- a/hi.txt
+++ b/hi.txt
@@ -1 +1 @@
-Hello
+Hello world
```

Working with Multiple Patches
=============================

StGit is most useful when working on more than one patch concurrently.
Let's add another patch to improve the goodbye.

```sh
$ stg new -m "goodbye" goodbye-patch
Now at patch "goodbye-patch"
$ stg series
+ hello-patch
> goodbye-patch
$ echo "Farewell, cruel world." > bye.txt
$ stg refresh
Now at patch "goodbye-patch"
```

These patches are looking good\...except the greeting is missing
punctuation! With StGit, we can easily revisit `hello-patch`, make our
punctuation modifications, and return to `goodbye-patch` using `stg pop`
and `stg push`:

```sh
$ stg pop
Popped goodbye-patch
Now at patch "hello-patch"
$ echo "Hello, world." > hi.txt
$ stg refresh
Now at patch "hello-patch"
$ stg push
Pushing patch "goodbye-patch" ... done
Now at patch "goodbye-patch"
```

These patches are looking good, but we want to make sure to have quality
commit messages before we call these patches complete. Let's update the
top patch (`goodbye-patch`) with an improved commit message. This can be
done using `stg edit`:

```sh
$ stg edit -m "Use elaborate farewell"
```

Perfect. Our last step is to commit these patches to the repository's
history using `stg commit`. We will use the `--all` option to indicate
that we want all applied patches to be committed.

```sh
$ stg commit --all
```

StGit patches are regular, first-class Git commit objects. They are
visible when running `git log` and can be manipulated using regular Git
commands. So `stg commit` does not modify the patches (commits), instead
it is updating the StGit stack state to note that those patches have
graduated, and are no longer in the series.
