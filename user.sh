trojan=$(grep -c -E "^#### " "/etc/xray/trojan-ws.json")
vless=$(grep -c -E "^#### " "/etc/xray/vless-tls.json")
vmess=$(grep -c -E "^#### " "/etc/xray/vmess-ws.json")
grpc=$(grep -c -E "^#### " "/etc/xray/trojan-grpc.json")

echo "============================"
echo " TROJAN= ${trojan}  Users"
echo " VLESSS= ${vless}  Users"
echo " VMESSS= ${vmess}  Users"
echo " gRPCCC= ${grpc}  Users"
echo " Total Users= $[trojan + vless + vmess + grpc] Users"
echo "============================"
