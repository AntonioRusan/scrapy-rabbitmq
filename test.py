import pika
import json
connection = pika.BlockingConnection(pika.URLParameters('amqp://guest:guest@localhost:5672/'))
channel = connection.channel()
queue_key = 'test_crawl_orders'

# Read the link in the file and write it to the queue with id
with open('urls.txt') as f:
    id = 1
    for url in f:
        url = url.strip(' \n\r')
        order = {
            "order_id": id,
            "url": url,
        }
        orderJson = json.dumps(order)
        print(orderJson)

        channel.basic_publish(exchange='',
                        routing_key=queue_key,
                        body=orderJson,
                        properties=pika.BasicProperties(
                            content_type='application/json',
                            delivery_mode=2
                        ))
        id += 1

connection.close()
