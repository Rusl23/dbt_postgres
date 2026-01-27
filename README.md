# dbt_snowflake
Проект посвящен использованию dbt и Snowflake для построения аналитического слоя: модели данных, тестирование, документация и повторяемые пайплайны трансформаций.

## Что внутри
- dbt-проект для трансформаций и витрин
- Snowflake как основная аналитическая БД
- тесты качества данных (dbt tests)
- генерация документации (dbt docs)

## Быстрый старт
1) Установите зависимости проекта (если используется `requirements.txt` или `dbt` в virtualenv).
2) Настройте профиль dbt для Snowflake в `~/.dbt/profiles.yml`.
3) Запустите:
```bash
dbt debug
dbt deps
dbt run
dbt test
```

Если профиль хранится в репозитории, используйте переменную окружения:
```bash
export DBT_PROFILES_DIR=./.dbt
```

## Требования
- dbt-core + dbt-snowflake (совместимые версии)
- Доступ к Snowflake (account, user, role, warehouse, database, schema)

## Полезные команды
```bash
dbt run --select <model>
dbt test --select <model>
dbt docs generate
dbt docs serve
```

## Структура проекта
Обычно включает папки:
- `models/` — SQL-модели и описания
- `macros/` — переиспользуемые макросы
- `tests/` — пользовательские тесты
- `seeds/` — статические данные
- `snapshots/` — отслеживание изменений
- `data/` — исходные CSV (orders, returns, users) и SQL для загрузки в Postgres

## Модели
Сейчас готов **stg слой** (staging). Он находится в `dbt_dwh/models/stg/` и включает:
- `stg_orders.sql`
- `stg_returns.sql`
- `stg_managers.sql`

Источники описаны в `dbt_dwh/models/sources/`.

## Профили: dev и prod
В `~/.dbt/profiles.yml` настроены targets `dev` и `prod` (разные `schema` в одной базе).
Пример запуска:
```bash
dbt run --target dev
dbt run --target prod
```
Если `--target` не указан, используется значение `target` из профиля.

## Pre-commit хуки
В проекте настроен pre-commit с SQLFluff для SQL и `check-yaml` для YAML в `dbt_dwh/models/`.
Основные команды:
```bash
pre-commit install
pre-commit run --all-files
```
Хуки запускаются автоматически при `git commit` и проверяют только staged файлы.

## Загрузка данных в Postgres (опционально)
В папке `data/` лежит файл `load_postgres.sql` с `CREATE TABLE` и `INSERT INTO` для CSV.
