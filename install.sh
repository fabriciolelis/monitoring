#!/bin/bash

# install prometheus

mkdir -p /etc/prometheus
mkdir -p /var/lib/prometheus
useradd --no-create-home --shell /bin/false prometheus
curl -LO  https://github.com/prometheus/prometheus/releases/download/v2.32.1/prometheus-2.32.1.linux-amd64.tar.gz
tar -zxvf prometheus-2.32.1.linux-amd64.tar.gz
cp prometheus-2.32.1.linux-amd64/prometheus /usr/local/bin/
cp prometheus-2.32.1.linux-amd64/promtool /usr/local/bin/
chown prometheus:prometheus /usr/local/bin/prometheus 
chown prometheus:prometheus /usr/local/bin/promtool
cp -R prometheus-2.32.1.linux-amd64/consoles/ /etc/prometheus/
cp -R prometheus-2.32.1.linux-amd64/console_libraries/ /etc/prometheus/
cp prometheus.yml /etc/prometheus
cp alert.rules /etc/prometheus

chown prometheus:prometheus /etc/prometheus -R
chown prometheus:prometheus /var/lib/prometheus -R

cp prometheus.service /etc/systemd/system/
systemctl daemon-reload
systemctl start prometheus

#install alertmanager

curl -LO https://github.com/prometheus/alertmanager/releases/download/v0.23.0/alertmanager-0.23.0.linux-amd64.tar.gz
tar -xzvf alertmanager-0.23.0.linux-amd64.tar.gz
cp alertmanager-0.23.0.linux-amd64/alertmanager /usr/local/bin/
chown prometheus:prometheus /usr/local/bin/alertmanager
mkdir -p /etc/alertmanager
mkdir -p /var/lib/alertmanager/data
cp config.yml /etc/alertmanager
chown prometheus:prometheus /etc/alertmanager -R
cp alertmanager.service /etc/systemd/system/
systemctl daemon-reload
systemctl start alertmanager