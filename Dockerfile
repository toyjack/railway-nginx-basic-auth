FROM nginx:alpine AS runtime

ARG PROXY_PASS=http://host.docker.internal:3000
ARG PORT=4000
ARG USERNAME=user
ARG PASSWORD=password

RUN echo "proxy_pass: $PROXY_PASS\nport: $PORT\nusername: $USERNAME\npassword: $PASSWORD"

COPY ./nginx.conf.template /etc/nginx/nginx.conf.template
RUN envsubst '$PROXY_PASS $PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf


ENV USERNAME=$USERNAME
ENV PASSWORD=$PASSWORD
RUN apk add --no-cache openssl
COPY ./gen_passwd.sh /etc/nginx/gen_passwd.sh
RUN ["chmod", "+x", "/etc/nginx/gen_passwd.sh"]
RUN /etc/nginx/gen_passwd.sh
EXPOSE ${PORT}