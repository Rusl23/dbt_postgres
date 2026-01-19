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

## Загрузка данных в Postgres (опционально)
В папке `data/` лежит файл `load_postgres.sql` с `CREATE TABLE` и `INSERT INTO` для CSV.
Пример запуска:
```bash
psql -d <db> -f data/load_postgres.sql
```

## Примечания
Если в проекте есть специфичные модели или окружения, добавьте сюда их описание и правила запуска.
