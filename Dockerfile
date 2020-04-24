FROM alpine:3.8

RUN apk add --update logrotate && rm -rf /var/cache/apk/* && rm -rf /tmp/*
RUN echo "*/5 *	* * *	/usr/sbin/logrotate /etc/logrotate.conf" >> /etc/crontabs/root

COPY logrotate.conf /etc/logrotate.conf
RUN chmod 400 /etc/logrotate.conf

CMD ["crond", "-f"]
