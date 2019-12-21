#!/bin/bash

i=1

while [ $i -ge 0 ]
do
clear

# get date
DATE=$(date +'%a %H:%M:%S %d/%m/%Y')

# print date
echo $DATE

# print remaining battery time
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "time to" > $HOME/.time.info
grep -o '.........$' $HOME/.time.info > $HOME/.time.tmp
t="($(cat $HOME/.time.tmp))"
#TIME=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "time to")
echo $TIME

# print remaining battery percentage
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage > $HOME/.battery.info
grep -o '...$' $HOME/.battery.info > $HOME/.tmp.info
sed -i 's/.$//g' $HOME/.tmp.info
n=$(cat $HOME/.tmp.info)
#N=$((n/2))
N=$(cat $HOME/.tmp.info)
m=$((100-n))
#M=$((m/2))
M=$((100-N))
if [ $n -le 20 ]
then
	printf "battery:\t" && printf [ && printf "\e[0;31m%${N}s\e[m" | tr " " "|" && printf "%${M}s" | tr " " " " && printf "]" && echo " $t"
else
	printf "battery:\t" && printf [ && printf "\e[0;32m%${N}s\e[m" | tr " " "|" && printf "%${M}s" | tr " " " " && printf "]" && echo " $t"
fi	


# print available disk space
df -h | grep /dev/sdb2 > $HOME/.disk.info
sed -i 's/..$//' $HOME/.disk.info
sed -i 's/^..................................//' $HOME/.disk.info
sed -i 's/.$//' $HOME/.disk.info
n=$(cat $HOME/.disk.info)
#N=$((n/2))
N=$(cat $HOME/.disk.info)
m=$((100-n))
#M=$((m/2))
M=$((100-N))
if [ $n -le 90 ]
then
	printf "disk:\t\t" && printf [ && printf "\e[0;32m%${N}s\e[m" | tr " " "|" && printf "%${M}s" | tr " " " " && printf "]\n"
else
	printf "disk:\t\t" && printf [ && printf "\e[0;31m%${N}s\e[m" | tr " " "|" && printf "%${M}s" | tr " " " " && printf "]\n"
fi
sleep 10
done
