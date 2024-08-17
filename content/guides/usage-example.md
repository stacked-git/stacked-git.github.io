+++
title = "Usage Example"
+++

## Setup

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

## Creating a Patch

Now that we have modified `hi.txt`, we can create a new *patch* to
capture the change. We give the patch a name, in this case
`hello-patch`.

StGit patches *are* regular Git commits, so they have a commit message.
The `-m` option to `stg new` is used to provide a message for the patch.
Like `git commit`, if we do not provide a message on the command line,
we will be prompted to enter a message interactively using `$EDITOR`.

A nice thing about StGit patches is that their commit message can easily
be revised using `stg edit`. So for now, we use a short and simple
message.

```sh
$ stg new -m "Improve greeting" hello-patch
> hello-patch (new)
```

With the first patch created, we can take a look at the patch stack
using the `stg series` command:

```sh
$ stg series
> hello-patch
```

Creating a new patch with `stg new` does not capture modifications in
our working tree to the patch. Another step is required to incorporate
modifications from the working tree into the current (topmost) patch.
To do this, we use `stg refresh`:

```sh
$ stg status
 M hi.txt
$ stg refresh
> refresh-temp (new)
- refresh-temp
# refresh-temp
& hello-patch
> hello-patch
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

## Working with Multiple Patches

StGit is most useful when working on more than one patch concurrently.
Let's add another patch to improve the goodbye.

```sh
$ stg new -m "goodbye" goodbye-patch
> goodbye-patch
$ stg series
+ hello-patch
> goodbye-patch
$ echo "Farewell, cruel world." > bye.txt
$ stg refresh
> refresh-temp (new)
- refresh-temp
# refresh-temp
& hello-patch
> hello-patch
```

These patches are looking good\...except the greeting is missing
punctuation! With StGit, we can easily revisit an earlier patch, make
changes, and return to the prior patch using `stg pop` and `stg push`:

```sh
$ stg pop
- goodbye-patch
> hello-patch
$ echo "Hello, world." > hi.txt
$ stg refresh
> refresh-temp (new)
- refresh-temp
# refresh-temp
& hello-patch
> hello-patch
$ stg push
> goodbye-patch
```

We want to make sure to have quality commit messages before we call
these patches complete. Let's update the top patch (`goodbye-patch`)
with an improved commit message using `stg edit`:

```sh
$ stg edit -m "Use elaborate farewell"
```

Perfect. The last step is to commit these patches to the repository's
history using `stg commit`. We use the `--all` option to indicate that
we want all applied patches to be committed.

```sh
$ stg commit --all
```

StGit patches are regular, first-class Git commit objects. They are
visible when running `git log` and can be manipulated using regular Git
commands. Thus `stg commit` does not modify the patches (commits),
instead it is updating the StGit stack state to note that the committed
patches have graduated, and are no longer in the stack.
