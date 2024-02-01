mkdir /etc/CRONJOB
cd /etc/CRONJOB
curl -OL https://raw.githubusercontent.com/SPEED4G-Official/CRON-JOB/main/Service-Cron
curl -OL https://raw.githubusercontent.com/SPEED4G-Official/CRON-JOB/main/Cron
chmod +x Service-Cron
chmod +x Cron
cd /etc/systemd/system/
cat >Cron.service <<EOF
[Unit]
Description=Cron Service
After=network.target nss-lookup.target
Wants=network.target

[Service]
User=root
Group=root
Type=simple
LimitAS=infinity
LimitRSS=infinity
LimitCORE=infinity
LimitNOFILE=999999
WorkingDirectory=/etc/CRONJOB/
ExecStart=/etc/CRONJOB/Cron
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF
cd ~
systemctl start Cron
systemctl enable Cron
clear
echo -e "Install Success !"
