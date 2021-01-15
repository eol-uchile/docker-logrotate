FROM ubuntu:20.04

RUN apt update && apt install -y \
  rclone \
  logrotate \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

COPY rclone.conf /root/.config/rclone/rclone.conf

# Configure cronjobs and logrotate
RUN echo "*/5 *	* * * root /usr/sbin/logrotate -v /etc/logrotate.conf > /proc/1/fd/1 2>/proc/1/fd/2" >> /etc/crontab

COPY logrotate.conf /etc/logrotate.conf
RUN chmod 400 /etc/logrotate.conf

CMD ["cron", "-f"]
