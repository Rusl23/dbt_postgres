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

## Incremental models (orders)
In `dbt_dwh/models/bronze/`, there are three incremental variants of the orders staging model. They share the same `SELECT` logic and an identical incremental filter, but differ in how they write changes to the target table.

Common logic:
- `unique_key = ['dwh_id']` with `dwh_id` generated from the same set of order attributes.
- Incremental window:
  `WHERE order_date >= (SELECT max(order_date) FROM {{ this }}) - interval '7 day'`

Strategies:
- `stg_orders_append` (`incremental_strategy = 'append'`)
  - Inserts only. No updates or deletes.
  - With a 7-day window, this can create duplicates unless the target enforces uniqueness on `dwh_id`.
- `stg_orders_delete_insert` (`incremental_strategy = 'delete+insert'`)
  - Deletes matching keys in the window, then inserts fresh rows.
  - Good for reloading recent days and keeping data consistent in that window.
- `stg_orders_merge` (`incremental_strategy = 'merge'`)
  - Upserts rows: updates matched keys and inserts new ones.
  - Functionally similar to delete+insert, but without an explicit delete step.

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
