#!/bin/bash
echo "">>firewall.user
echo "# IPID防火墙配置">>firewall.user
echo "# iptables -t mangle -N IPID_MOD">>firewall.user
echo "# iptables -t mangle -A FORWARD -j IPID_MOD">>firewall.user
echo "# iptables -t mangle -A OUTPUT -j IPID_MOD">>firewall.user
echo "# iptables -t mangle -A IPID_MOD -d 0.0.0.0/8 -j RETURN">>firewall.user
echo "# iptables -t mangle -A IPID_MOD -d 127.0.0.0/8 -j RETURN">>firewall.user
echo "# iptables -t mangle -A IPID_MOD -d 10.0.0.0/8 -j RETURN">>firewall.user
echo "# iptables -t mangle -A IPID_MOD -d 172.16.0.0/12 -j RETURN">>firewall.user
echo "# iptables -t mangle -A IPID_MOD -d 192.168.0.0/16 -j RETURN">>firewall.user
echo "# iptables -t mangle -A IPID_MOD -d 255.0.0.0/8 -j RETURN">>firewall.user
echo "# iptables -t mangle -A IPID_MOD -j MARK --set-xmark 0x10/0x10">>firewall.user
echo "">>firewall.user
echo "# NTP防火墙配置">>firewall.user
echo "# iptables -t nat -N ntp_force_local">>firewall.user
echo "# iptables -t nat -I PREROUTING -p udp --dport 123 -j ntp_force_local">>firewall.user
echo "# iptables -t nat -A ntp_force_local -d 0.0.0.0/8 -j RETURN">>firewall.user
echo "# iptables -t nat -A ntp_force_local -d 127.0.0.0/8 -j RETURN">>firewall.user
echo "# iptables -t nat -A ntp_force_local -d 192.168.0.0/16 -j RETURN">>firewall.user
echo "# iptables -t nat -A ntp_force_local -s 192.168.0.0/16 -j DNAT --to-destination 192.168.1.1">>firewall.user
echo "">>firewall.user
echo "# TTL防火墙配置">>firewall.user
echo "# iptables -t mangle -I POSTROUTING 1 -j TTL --ttl-set 65">>firewall.user
echo "">>firewall.user
echo "# 深信服劫持Http防跳转">>firewall.user
echo "# iptables -I FORWARD -p tcp -m tcp --sport 8000 -m u32 --u32 "5&0xFF=0x7F:0x80" -j DROP">>firewall.user
echo "# iptables -I FORWARD -p tcp -m tcp --sport 8000 -m u32 --u32 "5&0xFF=0x7F" -j DROP">>firewall.user
echo "">>firewall.user
echo "# 屏蔽FlashCookie检测">>firewall.user
echo "# iptables -I FORWARD -p tcp --sport 80 --tcp-flags ACK ACK -m string --algo bm --string " src=\"http://1.1.1." -j DROP">>firewall.user