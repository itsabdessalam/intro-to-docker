FROM debian:stretch-slim

# Install Basic Requirements
RUN \
    apt-get update && \
    apt-get install -y nginx
    
# Override nginx's default config
RUN \
    rm -rf /etc/nginx/sites-enabled/default && \
    rm -rf /etc/nginx/conf.d/default.conf && \
    rm -rf /etc/nginx/conf.d/examplessl.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf

# Override default nginx content
COPY content /usr/share/nginx/html

# Add volumes
VOLUME ["/usr/share/nginx/html", "/etc/nginx"]

EXPOSE 80
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
