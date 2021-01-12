FROM alpine:3.8

RUN apk add python3
RUN apk add --update logrotate && rm -rf /var/cache/apk/* && rm -rf /tmp/*

# Install and configure s3cmd
RUN python3 -m pip install s3cmd
COPY .s3cfg /root/.s3cfg

# Configure cronjobs and logrotate
RUN echo "*/5 *	* * *	/usr/sbin/logrotate /etc/logrotate.conf" >> /etc/crontabs/root

COPY logrotate.conf /etc/logrotate.conf
RUN chmod 400 /etc/logrotate.conf

CMD ["crond", "-f"]
