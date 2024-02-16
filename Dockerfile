FROM python:3

ARG python_version=latest
ARG POETRY_HTTP_BASIC_GITLAB_USERNAME=__token__
ARG POETRY_HTTP_BASIC_GITLAB_PASSWORD
ARG POETRY_HTTP_BASIC_NEXUS_USERNAME
ARG POETRY_HTTP_BASIC_NEXUS_PASSWORD

# Set default values for environment variables
ENV SCRAPY_SPIDER=product_spider

# Set the working directory to /app.
WORKDIR home/app/

# Copy the project source code from the local host to the filesystem of the container at the working directory.
COPY scrapy_rabbitmq.egg scrapy_rabbitmq.egg
COPY scrapy.cfg scrapy.cfg

# Unzip inner egg file with crawler
RUN unzip -o scrapy_rabbitmq.egg

#Install poetry
RUN pip install poetry

#Install poetry dependencies
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev

# Run the crawler when the container launches.
ENTRYPOINT ["scrapy", "crawl", "product_spider"]
# Settings for rabbitmq, should be set in docker-compose.yaml or k8s yaml
#CMD ["-s", "RABBITMQ_HOST=amqp://guest:guest@localhost:5672/%2F", "-s", "RABBITMQ_INPUT_QUEUE_KEY=scrapy_crawl_orders", "-s", "RABBITMQ_OUTPUT_QUEUE_KEY=scrapy_crawl_results"]