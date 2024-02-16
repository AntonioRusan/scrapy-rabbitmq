#!/bin/bash

# Copy scrapy.cfg and .egg file ro current directory
cp scrapy_rabbitmq_scheduler/scrapy_rabbitmq.egg scrapy_rabbitmq.egg
cp scrapy_rabbitmq_scheduler/scrapy.cfg scrapy.cfg

# Pack scrapy.cfg and .egg file to one zip
zip scrapy_rabbitmq.zip scrapy_rabbitmq.egg scrapy.cfg Dockerfile

# Delete copies of scrapy.cfg and .egg file
rm scrapy_rabbitmq.egg
rm scrapy.cfg