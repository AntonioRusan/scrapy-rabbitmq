# scrapy-rabbitmq
**Сборщик на Scrapy в связке с RabbitMQ**

Тестовый сборщик **product_spider**:
* использует очередь **'test_urls'** для получения url вида https://demo-site.at.ispras.ru/product/{id}; 
* парсит страничку;
* пишет сообщения в виде json {'url','id','name'} в очередь **'test_item'**.


Необходимо сбилдить docker образ сборщика командой ```docker build -t mycrawler .```

Поднять сборщик и RabbitMQ: ```docker-compose up -d```

Для того, чтобы положить ссылки из **urls.txt** в очередь **'test_urls'** надо выполнить скрипт **test.py**
