FROM alpine:latest

# Install wget and bash (for better script handling)
RUN apk add --no-cache wget bash

# Set working directory
WORKDIR /data

# Copy the script into the container
COPY fetch_website.sh /usr/local/bin/fetch_website.sh
RUN chmod +x /usr/local/bin/fetch_website.sh

# Set environment variable for domain
ENV DOMAIN "example.com"
ENV USERAGENT "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"

# Run the script when the container starts
CMD ["/usr/local/bin/fetch_website.sh"]
