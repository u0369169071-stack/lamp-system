FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install Apache2
RUN apt-get update && apt-get install -y apache2 libapache2-mod-php php php-cli php-common
RUN apt-get install -y mariadb-server
RUN apt-get install -y mycli

# Configure Apache to listen on port 8081
RUN sed -i 's/80/8081/g' /etc/apache2/ports.conf && \
    sed -i 's/:80/:8081/g' /etc/apache2/sites-available/000-default.conf

# Expose the custom port
EXPOSE 8081
