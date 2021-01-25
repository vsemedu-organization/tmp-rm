FROM openjdk:8-jre-alpine

LABEL maintainer="em1k"

RUN apk update && apk add bash

ADD docker-rm /temp/docker-rm

RUN cat /temp/docker-rm >> /etc/crontabs/root

RUN rm /temp/docker-rm

RUN mkdir -p /home/admin/tmp && chmod a+rwx /home/admin/tmp

RUN touch /var/log/cron.log

RUN chmod a+rwx /var/log/cron.log

CMD crond 2>&1  >/dev/null && tail -f /var/log/cron.log