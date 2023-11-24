# As Scrapy runs on Python, I choose the official Python 3 Docker image.
FROM python:3

# Set default values for environment variables
ENV SCRAPY_SPIDER=product_spider

# Set the working directory to /app.
WORKDIR /app

# Copy the file from the local host to the filesystem of the container at the working directory.
COPY requirements.txt ./

# Install Scrapy specified in requirements.txt.
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy the project source code from the local host to the filesystem of the container at the working directory.
COPY test_scrapy_rabbit .

# Run the crawler when the container launches.
CMD scrapy crawl $SCRAPY_SPIDER