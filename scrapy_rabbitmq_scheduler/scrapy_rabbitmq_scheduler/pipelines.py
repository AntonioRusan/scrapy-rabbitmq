import logging
from scrapy.utils.serialize import ScrapyJSONEncoder

from . import connection

default_serialize = ScrapyJSONEncoder().encode

logger = logging.getLogger('scrapy_rabbitmq_scheduler.pipeline.RabbitmqPipeline')

class RabbitmqPipeline(object):
    def __init__(self, output_queue_key, connection_url):
        self.server = connection.connect(connection_url)
        self.output_queue_key = output_queue_key
        self.serialize = default_serialize
        self.channel = connection.get_channel(self.server, self.output_queue_key)

    @classmethod
    def from_crawler(cls, crawler):
        if 'RABBITMQ_OUTPUT_QUEUE_KEY' in crawler.settings:
            output_queue_key = crawler.settings.get('RABBITMQ_OUTPUT_QUEUE_KEY')
        else:
            output_queue_key = 'output_queue_key_{spider_name}'.format(
                spider_name=crawler.spider.name)
        return cls(output_queue_key=output_queue_key,
                   connection_url=crawler.settings.get(
                       'RABBITMQ_CONNECTION_PARAMETERS'))

    def process_item(self, item, spider):
        data = self.serialize(item)
        try_time = 1
        while try_time <= 10:
            try:
                self.channel.basic_publish(exchange='',
                                            routing_key=self.output_queue_key,
                                            body=data)
                return
            except Exception as e:
                logger.exception(e)
                logger.error('process item failed! try_time:{}'.format(try_time))
                try_time += 1
                self.channel = connection.get_channel(self.server, self.output_queue_key)
        return item

    def close(self):
        """Close channel"""
        logger.error('pipeline channel is closed!!!!!!!!!!!')
        self.channel.close()
