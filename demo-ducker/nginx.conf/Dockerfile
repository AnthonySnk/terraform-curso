# DE QUE IMAGEN SALDRA 
FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY hello-world.conf /etc/ngnix/conf.d/hello-world.conf
RUN mkdir -p /usr/share/nginx/html/hello
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80

