#!/bin/bash

cp scrapy_rabbitmq_scheduler/scrapy_rabbitmq.egg scrapy_rabbitmq.egg
cp scrapy_rabbitmq_scheduler/scrapy.cfg scrapy.cfg

zip scrapy_rabbitmq.zip scrapy_rabbitmq.egg scrapy.cfg Dockerfile

rm scrapy_rabbitmq.egg
rm scrapy.cfg