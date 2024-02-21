# -*- coding: utf-8 -*-
import scrapy
import pickle
from scrapy.utils.request import request_from_dict


class RabbitSpider(scrapy.Spider):
    def _make_request(self, method_frame, header_frame, body):
        try:
            #request = request_from_dict(pickle.loads(body), self) // не понял зачем тут pickle.loads(body)
            request = request_from_dict(body)
        except Exception as e:
            body = body.decode()
            request = scrapy.Request(body, callback=self.parse, dont_filter=True)
        return request
