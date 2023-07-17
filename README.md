# psqldba

psql - PostgreSQL interactive terminal configuration and utilities

## Install

```zsh
cd ~
git clone git@github.com:s6o/psqldba.git
```

### PATH

Update your PATH environment variable (in `.bashrc`, `.zshrc` etc.) and include
the `$HOME/psqldba/bin` directory in PATH.

**Don't forget to source (re-load) your changes.**

```zsh
source ~/.zshrc
```

### ~/.psqlrc

To get a nicer psql prompt, plus some default configurations (e.g. per database
command history stored in `~/psqldba`) symlink `~/psqldba/.psqlrc` to `$HOME`
directory:

```zsh
cd ~
ln -s ~/psqldba/.psqlrc
```

## Neovim/VIM integration

The [psql](https://www.postgresql.org/docs/current/app-psql.html) can use
[Neovim](https://github.com/neovim/neovim) or [VIM](https://github.com/vim/vim)
for editing via `\e` with the pre-requiste that the `EDITOR` and/or `VISUAL`
environment variable has been set to the respective executable: `vim` or `nvim`
(in `.bashrc`, `.zshrc` etc.).

In addtion Neovim/VIM can be used as `PAGER` (i.e. command and/or query results
are loaded into VIM). To make it easier to use a `psql` wrapper is provided:

```zsh
pgvim -U postgres
```

to start `psql` with `PAGER` configured to `always` on.

If both: Neovim and VIM are installed, Neovim is the default.

### psql prompt edit mode

To get `vi` edit mode support on `psql` prompt symlink `~/psqldba/.inputrc` to
your `$HOME` directory:

```zsh
cd ~ 
ln -s ~/psqldba/.inputrc
```

or when you already have an existing `.inputrc` you can include the respective
configuration in you exsiting `.inputrc` by appending the line:

```text
$include ~/psqldba/.psql-vi-mode
```

## Using pre-defined SQL queries

The `psqldba` comes with a few pre-defined SQL queries that can be executed in
[psql](https://www.postgresql.org/docs/current/app-psql.html) via `\i` e.g.:

```zsh
psql -U postgres postgres
\i ~/psqldba/sql/current-database-size.sql
```

resulting in (something like)

```text
 current_db_size 
-----------------
 8665 kB
(1 row)
```

## Testing (dry-run) database changes

The `psqldba` comes with `pgtx` [psql](https://www.postgresql.org/docs/current/app-psql.html)
wrapper that allows to dry-run a SQL script by creating a transaction
(file `~/psqldba/history/.pgtx`) and by default running that file in a single
transaction with rollback. For more details:

```zsh
pgtx
```
