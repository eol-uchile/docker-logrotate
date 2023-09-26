FROM ubuntu:latest

ENV DEBIAN_FRONTEND "noninteractive"
RUN apt update && apt install -y \
  rclone \
  logrotate \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

COPY rclone.conf /root/.config/rclone/rclone.conf

# Configure cronjobs and logrotate for hourly frequency
RUN mv /etc/cron.daily/logrotate /etc/cron.hourly/logrotate
RUN sed -i 's#^/usr/sbin/logrotate#/usr/sbin/logrotate --log /proc/1/fd/1#' /etc/cron.hourly/logrotate

COPY logrotate.conf /etc/logrotate.d/tracking
RUN chmod 400 /etc/logrotate.d/tracking

CMD ["cron", "-f"]
