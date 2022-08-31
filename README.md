# psql-cfg

psql - PostgreSQL interactive terminal configuration and utilities

## Install

```zsh
cd ~
git clone git@github.com:s6o/psql-cfg.git
```

### PATH

Update your PATH environment variable (in `.bashrc`, `.zshrc` etc.) and include
the `$HOME/psql-cfg/bin` directory in PATH.

**Don't forget to source (re-load) your changes.**

```zsh
source ~/.zshrc
```

### ~/.psqlrc

To get a nicer psql prompt, plus some default configurations (e.g. per database
command history stored in `~/psql-cfg`) symlink `~/psql-cfg/.psqlrc` to `$HOME`
directory:

```zsh
cd ~
ln -s ~/psql-cfg/.psqlrc
```

## VIM integration

The [psql](https://www.postgresql.org/docs/current/app-psql.html) can use
[VIM](https://github.com/vim/vim) or [NeoVIM](https://github.com/neovim/neovim)
for editing via `\e` with the pre-requiste that the `EDITOR` and/or `VISUAL`
environment variable has been set to the respective executable: `vim` or `nvim`
(in `.bashrc`, `.zshrc` etc.).

In addtion VIM can be used as `PAGER` (i.e. command and/or query results are loaded
into VIM). To make it easier two `psql` wrappers are provided e.g.:

```zsh
pgvim -U postgres
```

to start `psql` with `PAGER` configured to `always` on and when found to use `nvim`
with fallback to `vim`, or:

```zsh
pgvis -U postgres
```

similar to above except that `nvim` or `vim` is expected to be loaded with the
[SpaceVim](https://github.com/SpaceVim/SpaceVim) configuration.

### psql prompt edit mode

To get `vi` edit mode support on `psql` prompt symlink `~/psql-cfg/.inputrc` to
your `$HOME` directory:

```zsh
cd ~ 
ln -s ~/psql-cfg/.inputrc
```

or when you already have an existing `.inputrc` you can include the respective
configuration in you exsiting `.inputrc` by appending the line:

```text
$include ~/psql-cfg/.psql-vi-mode
```

## Using pre-defined SQL queries

The `psql-cfg` comes with a few pre-defined SQL queries that can be executed in
[psql](https://www.postgresql.org/docs/current/app-psql.html) via `\i` e.g.:

```zsh
psql -U postgres postgres
\i ~/psql-cfg/sql/current-database-size.sql
```

resulting in

```text
 current_db_size 
-----------------
 8665 kB
(1 row)
```

## Testing (dry-run) database changes

The `psql-cfg` comes with `pgtx` [psql](https://www.postgresql.org/docs/current/app-psql.html) 
wrapper that allows to dry-run a SQL script by creating a transaction
(file `~/psql-cfg/history/.pgtx`) and by default running that file in a single
transaction with rollback. For more details:

```zsh
pgtx
```
