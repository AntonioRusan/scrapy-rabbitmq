# scrapy-rabbitmq
**Сборщик на Scrapy в связке с RabbitMQ**

Модуль, позволяющий создать паука, использующего очередь RabbitMQ для получения ссылок
и отправляя результат сбора в другую очередь.

Тестовый сборщик **product_spider** в проекте **test_project**:
* использует очередь **'scrapy_crawl_orders'** для получения url вида https://demo-site.at.ispras.ru/product/{id}; 
* парсит страничку;
* пишет сообщения в виде json {'url','id','name'} в очередь **'scrapy_crawl_results'**.

## Сборка проекта
- Выполняем скрипт `create_egg.sh` - создаётся egg-файл сборщика со всеми зависимостями;
- `make_zip.sh` - кладём egg-файл и Dockerfile в один архив, чтобы можно было собирать образ в kaniko;

Чтобы сбилдить docker образ сборщика локально выполняем -  ```docker build --build-arg POETRY_HTTP_BASIC_GITLAB_PASSWORD=gitlab_token -t scrapycrawler .```

## Тестирование
Поднять сборщик и RabbitMQ: ```docker-compose up -d```

Для того, чтобы положить ссылки из **urls.txt** в очередь **'scrapy_crawl_orders'** надо выполнить скрипт **test.py**
