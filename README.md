# dbt_postgres
This project focuses on using dbt and Postgres to build an analytics layer: data models, testing, documentation, and repeatable transformation pipelines.

## What's inside
- dbt project for transformations and marts
- Postgres as the primary analytics database
- data quality tests (dbt tests)
- documentation generation (dbt docs)

## Quick start
1) Install project dependencies (if using `requirements.txt` or dbt in a virtualenv).
2) Configure a dbt profile for Postgres in `~/.dbt/profiles.yml`.
3) Run:
```bash
dbt debug
dbt deps
dbt run
dbt test
```

If the profile is stored in the repo, use the environment variable:
```bash
export DBT_PROFILES_DIR=./.dbt
```

## Requirements
- dbt-core + dbt-postgres (compatible versions)
- Access to Postgres (host, port, user, password, database, schema)

## Useful commands
```bash
dbt run --select <model>
dbt test --select <model>
dbt docs generate
dbt docs serve
```

## Project structure
Typically includes:
- `models/` — SQL models and descriptions
- `macros/` — reusable macros
- `tests/` — custom tests
- `seeds/` — static data
- `snapshots/` — change tracking
- `data/` — source CSVs (orders, returns, users) and SQL for loading into Postgres

## Models
The **stg layer** (staging) is ready. It lives in `dbt_dwh/models/stg/` and includes:
- `stg_orders.sql`
- `stg_returns.sql`
- `stg_managers.sql`

Sources are defined in `dbt_dwh/models/sources/`.

## Profiles: dev and prod
In `~/.dbt/profiles.yml`, targets `dev` and `prod` are configured (different schemas in the same database).
Example:
```bash
dbt run --target dev
dbt run --target prod
```
If `--target` is not specified, the profile's `target` value is used.

## Pre-commit hooks
Pre-commit is configured with SQLFluff for SQL and `check-yaml` for YAML in `dbt_dwh/models/`.
Main commands:
```bash
pre-commit install
pre-commit run --all-files
```
Hooks run automatically on `git commit` and only check staged files.

## Load data into Postgres (optional)
In `data/`, there is a `load_postgres.sql` file with `CREATE TABLE` and `INSERT INTO` statements for CSVs.
