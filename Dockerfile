# As Scrapy runs on Python, I choose the official Python 3 Docker image.
FROM python:3

#Install poetry
RUN pip install poetry

# Set default values for environment variables
ENV SCRAPY_SPIDER=product_spider

# Set the working directory to /app.
WORKDIR /app

# Copy the project source code from the local host to the filesystem of the container at the working directory.
COPY scrapy_rabbitmq_scheduler ./

#Install poetry dependencies
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev

# Run the crawler when the container launches.
#CMD scrapy crawl $SCRAPY_SPIDER