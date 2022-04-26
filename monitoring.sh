#!/bin/bash
#== COLOR ==

title='\e[0;35m%s\e[0m\n'

#==  ARCHITECTURE ==

ARC1=$(hostnamectl | grep "Operating System" | cut -d" " -f5-)
ARC2=$(cat /proc/cpuinfo | grep "model name" | cut -d" " -f3-)
ARC3=$(arch)

ARC="${ARC1} ${ARC2} ${ARC3}"

#== CPU PHYSICAL ==

CPUP=$(cat /proc/cpuinfo | grep "processor" | wc -l)

#== VIRTUAL CPU: ==

VCPU=$(cat /proc/cpuinfo | grep "processor" | wc -l)

#== MEMORY USAGE ==

MEMU=$(free -m | grep "Mem" | awk '{printf "%d/%dMB (%.2f%%)", $3, $2, $3*100/$2}')

#== DISK USAGE ==

DISKU=$(df -h --total | grep "total" | awk '{printf "%s/%dGB (%s)", $3-G, $2, $5}')

#== CPU LOAD ==

CPUL=$(top -bn1 | grep "load" | awk '{printf "%.2f", $(NF-2)}')

#== LAST BOOT ==

LSB=$(who -b | awk '{printf $3" "$4" "$5}')

#== LVM USE ==

LVMU=$(lsblk | grep "lvm" | awk '{if ($1) {print "yes";exit;} else {print "no"}}')

#== TCP CONNECTION ==

TCPC=$(netstat -an | grep "ESTABLISHED" | wc -l)

#== USER LOG ==

USL=$(who | cut -d " " -f1 | sort -u | wc -l)

#== NETWORK IP ==

NIP1=$(hostname -I | awk '{printf "IP %s", $1}')
NIP2=$(ip a | grep "link/ether" | awk '{printf "(%s)", $2}')
NIP="${NIP1} ${NIP2}"

#== SUDO ==

SUCMD=$(grep 'COMMAND' /var/log/auth.log | wc -l)

#== GLOBAL ==

wall "
`printf "$title" "#Architecture:"` ${ARC}
`printf "$title" "#CPU physical:"` ${CPUP}
`printf "$title" "#vCPU:"` ${VCPU}
`printf "$title" "#Memory Usage:"` ${MEMU}
`printf "$title" "#Disk Usage:"` ${DISKU}
`printf "$title" "#CPU Load:"` ${CPUL}
`printf "$title" "#Last boot:"` ${LSB}
`printf "$title" "#LVM use:"` ${LVMU}
`printf "$title" "#Connection TCP:"` ${TCPC}
`printf "$title" "#User log:"` ${USL}
`printf "$title" "#Network:"` ${NIP}
`printf "$title" "#Sudo:"` ${SUCMD}
" \
