#!/bin/bash
NC='\033[0m'
RED='\033[1;38;5;196m'
GREEN='\033[1;38;5;040m'
ORANGE='\033[1;38;5;202m'
BLUE='\033[1;38;5;012m'
BLUE2='\033[1;38;5;032m'
PINK='\033[1;38;5;013m'
GRAY='\033[1;38;5;004m'
NEW='\033[1;38;5;154m'
YELLOW='\033[1;38;5;214m'
CG='\033[1;38;5;087m'
CP='\033[1;38;5;221m'
CPO='\033[1;38;5;205m'
CN='\033[1;38;5;247m'
CNC='\033[1;38;5;051m'

function banner(){
echo -e ${CP}"   ______                                   _   _ _     _     _          __      #"
echo -e ${CP}"  / / __ ) _ __ _____      _____  ___      | | | (_) __| | __| | ___ _ __\ \     #"
echo -e ${CP}" | ||  _ \| '__/ _ \ \ /\ / / __|/ _ \_____| |_| | |/ _  |/ _  |/ _ \ '_ \| |    #"
echo -e ${CP}"< < | |_) | | | (_) \ V  V /\__ \  __/_____|  _  | | (_| | (_| |  __/ | | |> >   #"
echo -e ${CP}" | ||____/|_|  \___/ \_/\_/ |___/\___|     |_| |_|_|\__,_|\__,_|\___|_| |_| |    #"
echo -e ${CP}"  \_\                                                                    /_/     #"
echo -e ${CNC}"             An Advanced Tool To Surf The Internet Like A PRO                    #"
echo -e ${YELLOW}"                & Clean Logs Before You Get Caught                               #"
echo -e ${BLUE2}"                         Coded By: Machine404                                    #"
echo -e ${CP}"          Follow Me On:  ${CPO}Instagram: invisibleclay100                             #"
echo -e ${CP}"                         ${PINK}Twitter:   whoami4041                                   #"
echo -e ${RED}"##################################################################################\n "

}
if [[ $EUID -ne 0 ]]; then
   echo -e ${RED}"\n[ X ] This script must be run as root :) \n" 1>&2
   echo -e ${RED}"[ ✔ ] Usage: sudo ./exploit.sh"
   exit 1
fi
clear
banner
echo -e -n ${CPO}"\n[*] Checking dependencies configuration \n" 
sleep 1
if [[ "$(ping -c 1 8.8.8.8 | grep '100% packet loss' )" != "" ]]; then
  echo ${RED}"No Internet Connection"
  exit 1
  else
  echo -e ${GREEN} "\n[ ✔ ] Internet.............${GREEN}[ working ]"
fi
sleep 1
which curl > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e ${GREEN} "\n[ ✔ ] curl.............${GREEN}[ found ]"
else
echo -e $red "[ X ] curl  -> ${RED}not found "
echo -e ${YELLOW} "[ ! ] Installing curl "
apt-get install curl  > /dev/null 2>&1
echo -e ${BLUE} "[ ✔ ] Done installing ...."
fi
sleep 1
which tor > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e ${GREEN} "\n[ ✔ ] Tor.............${GREEN}[ found ]"
else
echo -e $red "[ X ] Tor  -> ${RED}not found "
echo -e ${YELLOW} "[ ! ] Installing tor "
apt-get install tor  > /dev/null 2>&1
echo -e ${BLUE} "[ ✔ ] Done installing ...."
fi
which jq > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e ${GREEN} "\n[ ✔ ] jq.............${GREEN}[ found ]"
else
echo -e $red "[ X ] jq  -> ${RED}not found "
echo -e ${YELLOW} "[ ! ] Installing jq "
sudo apt-get install jq
echo -e ${BLUE} "[ ✔ ] Done installing ...."
fi

sleep 2
function tor(){
clear
banner
echo -e -n ${CP}"\n[*] Checking Tor configuration \n" 
tori=$(curl --socks5 localhost:9050 --socks5-hostname localhost:9050 -s https://check.torproject.org/ | cat | grep -o "Congratulations" | xargs) 1>&2
if [[ $tori != '' ]]; then
echo -e -n ${CPO}"\n[*] Tor Service Already Enabled \n" 
sleep 1
ipchanger
else

echo -e -n ${CPO}"\n[*] Enabling Tor Services  \n" 
sleep 2
service tor start
sleep 2
ipchanger
fi
}
function ipchanger(){
clear
banner
api="https://www.myexternalip.com/json"
proxy="--socks5 127.0.0.1:9050"

echo -e -n ${BLUE}"\nMachine404@Hacks:~/Enter Time To Change IP in Seconds:  "
read change        #will sleep for a while

echo -e -n ${CP}"\nMachine404@Hacks:~/How Many IP's U want to Change: "
read time   #will reload tor again and again

for ((i = 0 ; i < $time ; i++)); do
sleep $change
res=$(curl $proxy -s $api | jq -r .ip) >/dev/null 2>&1 
 sudo service tor reload
echo -e -n ${CPO}"\nMachine404@Hacks:  IP changing to # $res "
done

}
function logkiller(){
clear
banner
echo -e -n ${RED}"\n[ ✔ ] Working On Your Logs \n"
sleep 2
log_list=( "/var/log/messages" "/var/log/auth.log" "/var/log/kern.log" "/var/log/cron.log" "/var/log/maillog" "/var/log/boot.log" "/var/log/mysqld.log" "/var/log/secure" "/var/log/utmp" "/var/log/wtmp " "/var/log/yum.log" "/var/log/system.log" "/var/log/DiagnosticMessages" "~/.zsh_history" "~/.bash_history")

for log in ${log_list[@]}; do
	if [ -f "$log" ];then
		shred -vfzu $log && :> $log
	fi
done &>/dev/null
echo -e -n ${CP}"\n[*] Cleaning Your System Logs :)\n"
sleep 2
echo -e -n ${NC}"\n[ ✔ ] Logs Successfully Cleaned! Now Run"
}
trap ctrl_c INT
ctrl_c() {
clear
echo -e ${RED}"[*] (Ctrl + C ) Detected, Trying To Exit... "
echo -e ${RED}"[*] Stopping Services... "

service tor stop
sleep 1
echo ""
echo -e ${YELLOW}"[*] Thanks For Using Browse-Hidden Tool  :) \n"
echo -e ${CNC}"[ ✔ ] Follow Me On:     ${CPO}Instagram: invisibleclay100        "
echo -e ${CP}"                         ${PINK}Twitter:   whoami4041          "
exit
}
function mac_change(){
which macchanger > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e ${GREEN} "\n[ ✔ ] macchanger.............${GREEN}[ found ]"
sleep 1
else
echo -e $red "[ X ] macchanger  -> ${RED}not found "
echo -e ${YELLOW} "[ ! ] Installing macchanger "
apt-get install macchanger  > /dev/null 2>&1
echo -e ${BLUE} "[ ✔ ] Done installing ...."
fi
clear
banner
eth=$(ip link show eth0 | awk '/ether/ {print $2}')

echo -e "\n${NC}[${CG}"*"${NC}]${CNC} Which Device Mac U Want To Change: \n"
echo -e "${NC}[${CG}"1"${NC}]${ORANGE} Ethernet (eth0) "
echo -e "${NC}[${CG}"2"${NC}]${BLUE} Wlan (Wlan0) "
echo -n -e ${CPO}"\n[+] Select: "
read choose

if [[ $choose -eq 1 ]]; 
then
echo -e -n ${CP}"\n[*] Your Current Ethernet Mac is: $eth \n"
sleep 1
echo -e -n ${CG}"\n[*] Now Changing To New Mac Address \n"
ma=$(macchanger -r eth0 | awk '/New MAC/{print $3}')
sleep 1
echo -e -n ${RED}"\n[ ✔ ] Your New Mac Address is:  $ma "

elif [[ $choose = 2 ]];
then
      wlan
fi
}
function wlan(){
clear
banner
ch=$(ifconfig | egrep "wlan0" > /dev/null 2>&1) 

if [[ $ch != '' ]];
then

wan=$(ip link show wlan0 | awk '/ether/ {print $2}' > /dev/null 2>&1 )
echo -e "YOur Current Wlan0 MAC: $wan"
sleep 1

echo -e -n ${CG}"\n[*] Now Changing To New Mac Address \n"
wan=$(macchanger -r wlan0 | awk '/New MAC/{print $3}')
echo -e -n ${RED}"\n[ ✔ ] Your New Mac Address is:  $wan "
else
echo -e -n ${RED}"\n[ X ] Wlan0 Address Not Found"
fi
}

menu(){
clear
banner
echo -e "\n${NC}[${CG}"*"${NC}]${CNC} Choose From the Following: \n"
echo -e "${NC}[${CG}"1"${NC}]${ORANGE} Auto Tor IP Changer"
echo -e "${NC}[${CG}"2"${NC}]${BLUE} Logs_killer"
echo -e "${NC}[${CG}"3"${NC}]${CG} Change Mac Address "
echo -e "${NC}[${CG}"4"${NC}]${RED} EXIT "
echo -n -e ${CPO}"\n[+] Select: "
read play
   if [ $play -eq 1 ]; then
          tor
   elif [ $play -eq 2 ]; then
          logkiller
   elif [ $play -eq 3 ]; then
          mac_change
  elif [ $play -eq 4 ]; then
          exit
      fi
}
menu
