FROM nginx:1.11.4-alpine
COPY root/etc/nginx/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
