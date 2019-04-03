# confman

A bash script to manage configurations.

***DEPRECATED***

The development has already closed.

I started this project on the assumption that use it to simplify my dotfiles.

But I think there are other methods I can use instead of this.

Perhaps I get back to it, if I feel like it.

## Design

### Example of directory structure

```
.
+-- confman/ (managed by git sumodule??)
|   +-- lib/
|   +-- Makefile
|   +-- dirman.sh
+-- our_config_dir/
|   +-- dir0/
|   |   +-- task.sh
|   +-- dir1/
+-- .confman
+-- .confman_cache/
    +-- versions/
        +-- dir0
        +-- dir1
```

### Usage

```
$ confman install
$ confman clean
$ confman update
```

### How it works

* On install
** Execute `install()` in `task.sh` in each directory under `${CONFMAN_TARGET_DIR}`.
** Then, write last commit hash of the target directory into version file under `${CONFMAN_CACHE_DIR}/versions`.

* On update
** Do the following to every managed directories.
*** Compare its latest commit hash and one written version file.
*** If there is a difference between them, then `update()` in `task.sh` should be executed, and replace contents for latest hash in version file.
*** If there is no version file for it, do `install()` rather than `update()`.

* On clean
** Execute `clean()` in `task.sh` in each directory under `${CONFMAN_TARGET_DIR}`.
** Then, remove all version files.
