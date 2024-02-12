#!/bin/bash

cd scrapy_rabbitmq_scheduler

#create lock-file with dependencies
poetry lock

#install dependencies from lock-file
poetry install

#build egg-file
poetry run build-egg name=scrapy_rabbitmq