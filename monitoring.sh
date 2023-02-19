#!/bin/bash

echo "#Architecture : $(uname -a)"
echo "#CPU physical : $(lscpu | grep "CPU(s)" | awk 'NR == 1 {print $2}')"
echo "#vCPU : $(nproc)"
mem=$(free --mega | grep Mem | awk '{print $3}')
total=$(free --mega | grep Mem | awk '{print $2}')
percent=$(free --mega | grep Mem | awk '{printf("%.2f", ($3*100/$2))}')
echo "#Memory Usage : ${mem}/${total}MB ($percent%)"
used=$(df -h --total | grep total | awk '{print $3}' | tr -d G)
available=$(df -h --total | grep total | awk '{print $4}' | tr -d G)
percent2=$(df -h --total | grep total | awk '{print $5}')
echo "#Disk Usage : ${used}/${available}GB ($percent2)"
echo "#CPU load : $(top -bn1 | grep "%Cpu(s)" | awk '{printf("%.1f", ($2+$4+$6))}')"
echo "#Last boot : $(who -b | awk '{print $3 " " $4}')"
lvm=$(lsblk | grep LVM | wc -l)
if [ $lvm -eq 0 ]
then
	echo "#LVM use : no"
else
	echo "#LVM use : yes"
fi
echo "#Connections TCP : $(netstat -t | grep tcp | wc -l) ESTABLISHED"
echo "#User log : $(who | wc -l)"
echo "#Network : IP $(hostname -I) ($(cat /sys/class/net/enp0s3/address))"
echo "#Sudo : $(cat /var/log/sudo/sudo.log | grep "COMMAND" | wc -l) cmd"
