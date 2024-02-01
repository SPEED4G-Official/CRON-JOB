transid="$1"
second="$2"
url="$3"
method="$4"
cd /etc/systemd/system/
cat >${transid}.service <<EOF
[Unit]
Description=${transid} Service
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
ExecStart=/etc/CRONJOB/Service-Cron --transid ${transid} --second ${second} --url ${url}
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF
