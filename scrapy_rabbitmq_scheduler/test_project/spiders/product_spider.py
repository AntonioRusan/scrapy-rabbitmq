from scrapy_rabbitmq_scheduler.spiders import RabbitSpider


class ProductSpider(RabbitSpider):
    name = 'product_spider'
    queue_name = 'test_messages'  # Specify the name of the task queue
    items_key = 'test_items'  # Specify item queue name

    def parse(self, response):
        product_id = response.url.split("/")[-1]
        product_name = response.css('h5.card-title::text').get()
        # print(f"\n===========================PRODUCT: id: {product_id}, name: {product_name}===============================\n")
        item = {
            'url': response.url,
            'id': product_id,
            'name': product_name
        }
        yield item
