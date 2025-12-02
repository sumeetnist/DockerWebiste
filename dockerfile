# Dockerfile
FROM nginx:alpine

# Copy config and site
COPY nginx.conf /etc/nginx/nginx.conf
COPY site/ /usr/share/nginx/html

# Validate Nginx config at build time (fail fast)
RUN nginx -t

# Security: run as default nginx user for static sites (alpine image uses uid 101)
# Note: serving static files is fine without root; port remap handled by container runtime.
EXPOSE 80

# Health check for orchestrators (optional)
# HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD wget -qO- http://localhost/ || exit 1
