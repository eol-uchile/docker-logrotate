# Image is ~ 30 MB
FROM ubuntu:20.04

# Python takes 37 MB
RUN apt update && apt install -y s3cmd && apt install -y logrotate

COPY .s3cfg /root/.s3cfg

# Configure cronjobs and logrotate
#RUN echo "*/5 *	* * *	/usr/sbin/logrotate /etc/logrotate.conf" >> /etc/crontabs/root
RUN echo "*/5 *	* * * root /usr/sbin/logrotate -v /etc/logrotate.conf > /proc/1/fd/1 2>/proc/1/fd/2" >> /etc/crontab

#COPY logrotate.conf /etc/logrotate.conf
RUN chmod 400 /etc/logrotate.conf

# CMD ["crond", "-f"]
CMD ["cron", "-f"]
