#!/bin/bash

# Get to scrapy crawler folder
cd scrapy_rabbitmq_scheduler

# Create lock-file with dependencies
poetry lock

# Install dependencies from lock-file
poetry install

# Build egg-file
poetry run build-egg name=scrapy_rabbitmq