sed -i 'd' /var/log/xray/vmess-ws.log
sed -i 'd' /var/log/xray/vless-ws.log
sed -i 'd' /var/log/xray/trojan-ws.log
sed -i 'd' /var/log/xray/trojan-tls.log
sed -i 'd' /var/log/xray/vless-tls.log
sed -i 'd' /var/log/xray/error.log
sed -i 'd' /var/log/xray/access5.log
systemctl restart trojan
systemctl restart trojan-grpc
systemctl restart trojan-ws
systemctl restart vmess-ws
systemctl restart vless-ws
systemctl restart vless-tls


