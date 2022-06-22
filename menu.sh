#!/bin/bash
clear
author=$(cat /etc/nur/author)
m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
echo -e "$y                  MENU UTAMA $wh"
echo -e "$y            Script Mod By ${author} $wh"
echo -e "$y-------------------------------------------------$wh"
echo -e "$yy 1$y.  TROJAN MENU  $wh"
echo -e "$yy 2$y.  VMESS MENU   $wh"
echo -e "$yy 3$y.  VLESS MENU   $wh"
echo -e "$yy 4$y.  gPRC MENU    $wh"
echo -e "$y-------------------------------------------------$wh"
read -p "Select From Options [ 1 - 4 ] : " menu
case $menu in
1)
clear
trojanmenu
;;
2)
clear
vlessmenu
;;
3)
clear
vmessmenu
;;
4)
clear
grpcmenu
;;
*)
clear
menu
;;
esac
