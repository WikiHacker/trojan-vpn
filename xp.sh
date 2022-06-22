#!/bin/bash
data=( `cat /etc/xray/trojan.json | grep '^####' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#### $user" "/etc/xray/trojan.json" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/trojan.json
fi
done
systemctl restart trojan

data=( `cat /etc/xray/trojan-ws.json | grep '^####' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#### $user" "/etc/xray/trojan-ws.json" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/trojan-ws.json
fi
done
systemctl restart trojan-ws

data=( `cat /etc/xray/trojan-grpc.json | grep '^####' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#### $user" "/etc/xray/trojan-grpc.json" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/trojan-grpc.json
fi
done
systemctl restart trojan-grpc

data=( `cat /etc/xray/vless-ws.json | grep '^####' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#### $user" "/etc/xray/vless-ws.json" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/vless-ws.json
fi
done
systemctl restart vless-ws

data=( `cat /etc/xray/vless-tls.json | grep '^####' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#### $user" "/etc/xray/vless-tls.json" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/vless-tls.json
fi
done
systemctl restart vless-tls

data=( `cat /etc/xray/vmess-ws.json | grep '^####' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#### $user" "/etc/xray/vmess-ws.json" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/vmess-ws.json
fi
done
systemctl restart vmess-ws
