#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
#MYIP=$(wget -qO- ipinfo.io/ip);
#echo "Checking VPS"
#IZIN=$( curl ipinfo.io/ip | grep $MYIP )
#if [ $MYIP = $MYIP ]; then
#echo -e "${NC}${GREEN}Permission Accepted...${NC}"
#else
#echo -e "${NC}${RED}Permission Denied!${NC}";
#echo -e "${NC}${LIGHT}Fuck You!!"
#exit 0
MYIP=$(wget -qO- ipinfo.io/ip);
clear
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
#nontls="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Username : " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/trojan-grpc.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${user}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days) : " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray$/a\#### '"$user $exp"'\
},{"password": "'""$user""'","email": "'""$user""'"' /etc/xray/trojan-grpc.json
xraytrojan="trojan://${user}@${domain}:2087?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=isi-bugmu-ngab#${user}"
systemctl restart trojan-grpc
service cron restart
clear
author=$(cat /etc/nur/author)
echo -e ""
echo -e "======-XRAYS/TROJAN-======"
echo -e "Remarks     : ${user}"
echo -e "IP/Host     : ${MYIP}"
echo -e "Address     : ${domain}"
echo -e "Port TLS    : 2087"
echo -e "Key         : ${user}"
echo -e "Network     : gRPC"
echo -e "serviceNam  : trojan-grpc"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e "========================="
echo -e "Link gRPC    : ${xraytrojan}"
echo -e "========================="
echo -e "Script Mod By ${author}"

