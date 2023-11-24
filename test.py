import pika
connection = pika.BlockingConnection(pika.URLParameters('amqp://guest:guest@localhost:5672/'))
channel = connection.channel()
queue_key = 'test_urls'

# Read the link in the file and write it to the queue
with open('urls.txt') as f:
    for url in f:
        url = url.strip(' \n\r')
        print(url)
        channel.basic_publish(exchange='',
                        routing_key=queue_key,
                        body=url,
                        properties=pika.BasicProperties(
                            content_type='text/plain',
                            delivery_mode=2
                        ))

connection.close()
