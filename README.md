# scrapy-rabbitmq
**Сборщик на Scrapy в связке с RabbitMQ**

Модуль, позволяющий создать паука, использующего очередь RabbitMQ для получения ссылок
и отправляя результат сбора в другую очередь.

Тестовый сборщик **product_spider** в проекте **test_project**:
* использует очередь **'test_messages'** для получения url вида https://demo-site.at.ispras.ru/product/{id}; 
* парсит страничку;
* пишет сообщения в виде json {'url','id','name'} в очередь **'test_items'**.


Необходимо сбилдить docker образ сборщика командой ```docker build -t testcrawler .```

Поднять сборщик и RabbitMQ: ```docker-compose up -d```

Для того, чтобы положить ссылки из **urls.txt** в очередь **'test_messages'** надо выполнить скрипт **test.py**
