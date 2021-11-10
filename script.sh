# The architecture of your operating system and its kernel version.
echo -n "#Architecture: " && uname -a

#The number of physical processors. https://www.youtube.com/watch?v=tnh_UO9aZ94
echo -n "#CPU physical: " && cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l

#The number of virtual processors. https://webhostinggeeks.com/howto/how-to-display-the-number-of-processors-vcpu-on-linux-vps/
echo -n "#vCPU: " &&  cat /proc/cpuinfo | grep "processor" | wc -l

#The current available RAM on your server and its utilization rate as a percentage. https://stackoverflow.com/questions/10585978/how-to-get-the-percentage-of-memory-free-with-a-linux-command
echo -n "#Memory Usage: " &&
echo -n "$(free -m | awk 'NR==2' | awk '{ print $3 }')" &&
echo -n "/" &&
echo -n "$(free -m | awk 'NR==2' | awk '{ print $2 }')" &&
echo -n "MB" &&
echo -n " (" && echo -n "$(free | grep Mem | awk '{print $3/$2 * 100}')" &&
echo "%)"

#The current available memory on your server and its utilization rate as a percentage. https://phoenixnap.com/kb/linux-check-disk-space
echo -n "#Disk Usage: " &&
echo "$(df -h --total | grep total | awk '{ print $3"/"$2 " ("$5")" }')"

#The current utilization rate of your processors as a percentage.
echo -n "#CPU load: " &&
echo "$(mpstat | grep all | awk '{ print $3+$4+$5"%" }')"

#The date and time of the last reboot.
echo -n "#Last boot: " && 
echo "$(who -b | awk '{ print $3 " " $4 }')"

#Whether LVM is active or not.
echo "#LVM use: " &&

#The number of active connections.
echo -n "#Connections TCP: " &&
cat /proc/net/sockstat | grep "TCP:" | awk '{ print $'3'" ESTABLISHED" }'

#The number of users using the server. https://www.computerhope.com/issues/ch001649.htm
echo -n "#User log: " && ps -eaho user | sort -u | wc -l

#The IPv4 address of your server and its MAC (Media Access Control) address.
echo -n "#Network: IP " &&  
echo -n "$(hostname -I)" && 
ifconfig | awk '/ether/ { print "(" $2 ")"}'

#The number of commands executed with the sudo program.
echo -n "#Sudo: " &&
grep -c ‘COMMAND’ /var/log/sudo/logfile
&& echo "cmd"