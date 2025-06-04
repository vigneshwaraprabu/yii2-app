# Use smaller base image
FROM php:8.3-cli-alpine

# Set working directory
WORKDIR /var/www/html

# Install only required dependencies
RUN apk --no-cache add \
    unzip \
    git \
    curl \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy only composer files first (for better caching)
COPY composer.json composer.lock ./

# Install PHP dependencies (layer caching for faster rebuilds)
RUN composer install --no-interaction --prefer-dist

# Copy rest of the application
COPY . .

# Expose the app port
EXPOSE 9000

# Start Yii2 app
CMD ["php", "-S", "0.0.0.0:9000", "-t", "web"]

