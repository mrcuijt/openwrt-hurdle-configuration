#!/bin/sh

touch /tmp/ping_fail.log
touch /tmp/ping_history.log
if ! ping -4 -c 3 -s 1 -W 1 [Your VPN Server IPv4 interface address] 2>/dev/null |grep "ttl=[0-9]\+"
then
 echo "Fail_IPv4: `date +%Y-%m-%d\ %T` " >> /tmp/ping_fail.log
 ifup linodejp
 exit 0
else
 echo "IPv4 Active: `date +%Y-%m-%d\ %T` " >> /tmp/ping_history.log
fi

if ! ping -6 -c 3 -s 1 -W 1 [Your VPN server IPv6 IP] 2>/dev/null |grep "ttl=[0-9]\+"
then
 echo "Fail_IPv6: `date +%Y-%m-%d\ %T` " >> /tmp/ping_fail.log
 ifup linodejp
 exit 0
else
  echo "IPv6 Active: `date +%Y-%m-%d\ %T` " >> /tmp/ping_history.log
fi
