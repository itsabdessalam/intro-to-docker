FROM debian:latest

# Install Basic Requirements
RUN \
    apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/* && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    chown -R www-data:www-data /var/lib/nginx

# Override nginx's default config
RUN rm -rf /etc/nginx/sites-enabled/default
RUN rm -rf /etc/nginx/conf.d/default.conf
RUN rm -rf /etc/nginx/conf.d/examplessl.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf


# Override default nginx content
COPY content /usr/share/nginx/html

# Add volumes
VOLUME [ "/usr/share/nginx/html", "/etc/nginx"]

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
