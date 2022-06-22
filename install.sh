
#!/bin/bash
domain=$(cat /etc/xray/domain)
apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Jakarta
chronyc sourcestats -v
chronyc tracking -v
date
#domain
mkdir /etc/xray
touch /etc/xray/domain
read -p "(silahkan masukan domain anda) : " addres
echo "${addres}" >> /etc/xray/domain
#author
mkdir /etc/nur
touch /etc/nur/author
read -p "(Silahkan masukan Nama anda) : " nama
echo "${nama}" >> /etc/nur/author
#instal core
wget https://github.com/XTLS/Xray-install/raw/main/install-release.sh
bash install-release.sh
#create json
cat> /etc/xray/trojan.json << END
{
  "log": {
      "access": "/var/log/xray/trojan-tls.log",
      "error": "/var/log/xray/error.log",
      "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 31296,
      "listen": "127.0.0.1",
      "protocol": "trojan",
      "tag": "trojanTCP",
      "settings": {
        "clients": [
          {
            "password": "eef46d87-ae46-d801-e0d4-6c87ae46d802"
#xray
          }
        ],
        "fallbacks": [
          {
            "dest": "81"
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "none",
        "tcpSettings": {
          "acceptProxyProtocol": true
        }
      }
    }
  ],
  "outbounds": [
      {
          "protocol": "freedom",
          "tag": "direct"
      }
  ]
}
END
cat> /etc/xray/trojan-ws.json << END
{
   "log": {
      "access": "/var/log/xray/trojan-ws.log",
      "error": "/var/log/xray/error.log",
      "loglevel": "info"
  },
 "inbounds": [
    {
      "port": 60002,
      "listen": "127.0.0.1",
      "protocol": "trojan",
      "tag": "trojanWS",
      "settings": {
        "clients": [
          {
            "password": "eef46d87-ae46-d801-e0d4-6c87ae46d801"
#xray
          }
        ],
        "fallbacks": [
          {
            "dest": "81"
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/trojanws"
        }
      }
    }
  ],
  "outbounds": [
      {
          "protocol": "freedom",
          "tag": "direct"
      }
  ]
}
END
cat> /etc/xray/trojan-grpc.json << END
{
    "log": {
            "access": "/var/log/xray/access5.log",
        "error": "/var/log/xray/error.log",
        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 2087,
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password": "persaratan"
#xray
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "gun",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "${domain}",
                    "alpn": [
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/xray.crt",
                            "keyFile": "/etc/xray/xray.key"
                        }
                    ]
                },
                "grpcSettings": {
                    "serviceName": "trojan-grpc"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        }
    ]
}
END
cat> /etc/xray/vless-tls.json << END
{
  "log": {
      "access": "/var/log/xray/vless-tls.log",
      "error": "/var/log/xray/error.log",
      "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 443,
      "protocol": "vless",
      "tag": "VLESSTCP",
      "settings": {
        "clients": [
          {
            "id": "eef46d87-ae46-d801-e0d4-6c87ae46d801",
            "flow": "xtls-rprx-direct",
            "email": "trojan.ket-yt.xyz_VLESS_XTLS/TLS-direct_TCP"
#xray
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": 31296,
            "xver": 1
          },
          {
            "path": "/vmessws",
            "dest": 31298,
            "xver": 1
          },
          {
            "path": "/vlessws",
            "dest": 31297,
            "xver": 1
          },
          {
            "path": "/trojanws",
            "dest": 60002,
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "minVersion": "1.2",
          "alpn": [
            "http/1.1",
            "h2"
          ],
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key",
              "ocspStapling": 3600,
              "usage": "encipherment"
            }
          ]
        }
      }
    }
  ],
  "outbounds": [
      {
          "protocol": "freedom",
          "tag": "direct"
      }
  ]
}
END
cat> /etc/xray/vless-ws.json << END
{
  "log": {
      "access": "/var/log/xray/vless-ws.log",
      "error": "/var/log/xray/error.log",
      "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 31297,
      "listen": "127.0.0.1",
      "protocol": "vless",
      "tag": "VLESSWS",
      "settings": {
        "clients": [
          {
            "id": "eef46d87-ae46-d801-e0d4-6c87ae46d802"
#xray
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/vlessws"
        }
      }
    }
  ],
  "outbounds": [
      {
          "protocol": "freedom",
          "tag": "direct"
      }
  ]
}
END
cat> /etc/xray/vmess-ws.json << END
{
  "log": {
      "access": "/var/log/xray/vmess-ws.log",
      "error": "/var/log/xray/error.log",
      "loglevel": "info"
  },
  "inbounds": [
    {
      "listen": "127.0.0.1",
      "port": 31298,
      "protocol": "vmess",
      "tag": "VMessWS",
      "settings": {
        "clients": [
          {
            "id": "eef46d87-ae46-d801-e0d4-6c87ae46d801"
#xray
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/vmessws"
        }
      }
    }
  ],
  "outbounds": [
      {
          "protocol": "freedom",
          "tag": "direct"
      }
  ]
}
END
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 443 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
#profile
echo "cek-service" >> /root/.profile
echo "user" >> /root/.profile
echo "0 0 * * * root xp" >> /etc/crontab
echo "0 3 * * * root clear-log && reboot" >> /etc/crontab
#systemd
systemctl enable trojan
systemctl enable trojan-ws
systemctl enable trojan-grpc
systemctl enable vless-tls
systemctl enable vless-ws
systemctl enable vmess-ws

#copy ke /usr/bin
cd /root
cp xp.sh /usr/bin/xp
cp vmessmenu.sh /usr/bin/vmessmenu
cp vlessmenu.sh /usr/bin/vlessmenu
cp user.sh /usr/bin/user
cp trojanmenu.sh /usr/bin/trojanmenu
cp renew-vmess.sh /usr/bin/renew-vmess
cp renew-vless.sh /usr/bin/renew-vless
cp renew-trojan-grpc.sh /usr/bin/renew-trojan-grpc
cp renew-trojan.sh /usr/bin/renew-trojan
cp menu.sh /usr/bin/menu
cp help.sh /usr/bin/help
cp grpcmenu.sh /usr/bin/grpcmenu
cp del-vmess.sh /usr/bin/del-vmess
cp del-vless.sh /usr/bin/del-vless
cp del-trojan-grpc.sh /usr/bin/del-trojan-grpc
cp del-trojan.sh /usr/bin/del-trojan
cp clear-log.sh /usr/bin/clear-log
cp cert.sh /usr/bin/cert
cp cek-vmess.sh /usr/bin/cek-vmess
cp cek-vless.sh /usr/bin/cek-vless
cp cek-service.sh /usr/bin/cek-service
cp cek-trojan-grpc.sh /usr/bin/cek-trojan-grpc
cp cek-trojan.sh /usr/bin/cek-trojan
cp add-vmess.sh /usr/bin/add-vmess
cp add-vless.sh /usr/bin/add-vless
cp add-trojan-grpc.sh /usr/bin/add-trojan-grpc
cp add-trojan.sh /usr/bin/add-trojan
cd /usr/bin
chmod +x xp
chmod +x vmessmenu
chmod +x vlessmenu
chmod +x user
chmod +x trojanmenu
chmod +x renew-vmess
chmod +x renew-vless
chmod +x renew-trojan-grpc
chmod +x renew-trojan
chmod +x menu
chmod +x help
chmod +x grpcmenu
chmod +x del-vmess
chmod +x del-vless
chmod +x del-trojan-grpc
chmod +x del-trojan
chmod +x clear-log
chmod +x cert
chmod +x cek-vmess
chmod +x cek-vless
chmod +x cek-trojan-grpc
chmod +x cek-trojan
chmod +x cek-service
chmod +x add-vmess
chmod +x add-vless
chmod +x add-trojan-grpc
chmod +x add-trojan
cd
#install cert
cert
clear-log
bash .profile
echo "Sukses ngab"
