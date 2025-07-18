# Postgres Dev Environment Template

A dev test environment for Postgres in Nix.

## Usage

Clone the repo:

```bash
git clone https://github.com/Lekyaira/postgres-template <target-directory>
```

Edit `shell.nix` and change `PGDB = ` to whatever you want your database to be named.

Then run the Nix shell:

```bash
nix-shell
```

or

```bash
echo "use nix" > .envrc && direnv allow
```
