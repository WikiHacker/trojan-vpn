#!/bin/bash
NUMBER_OF_CLIENTS=$(grep -c -E "^#### " "/etc/xray/trojan-grpc.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo " ==============================="
	echo "     No  Expired   User"
	grep -E "^#### " "/etc/xray/trojan-grpc.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^#### " "/etc/xray/trojan-grpc.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#### " "/etc/xray/trojan-grpc.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
#sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/trojan.json
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/trojan-grpc.json
#systemctl restart trojan
systemctl restart trojan-grpc
clear
author=$(cat /etc/nur/author)
echo " Trojan gRPC Akun berhasil dihapus"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp"
echo " =========================="
echo " Mod by ${author}"

