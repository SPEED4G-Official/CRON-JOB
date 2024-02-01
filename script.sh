transid="$1"
second="$2"
url="$3"
method="$4"
if [ "$method" == "add" ]; then
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
cd ~
systemctl daemon-reload
systemctl start ${transid}
systemctl enable ${transid}
elif [ "$method" == "delete" ]; then
systemctl stop ${transid}
systemctl disable ${transid}
cd /etc/systemd/system/
rm -rf ${transid}.service
systemctl daemon-reload
cd ~
else
    echo "Method Not Support!"
fi


