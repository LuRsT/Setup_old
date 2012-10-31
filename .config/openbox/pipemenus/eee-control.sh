## ozzolo's eee-control pipe menu for Openbox 
## v 0.2
## tested on Asus eeePC 1000H
##
## 1) copy the script in ~/.config/openbox/pipemenus/eee-control.sh
## 2) change permissions: "chmod +x ~/.config/openbox/pipemenus/eee-control.sh"
## 3) edit   ~/.config/openbox/menu.xml  
##      add  <menu execute="~/.config/openbox/pipemenus/eee-control.sh" id="eee-control" label="eee control"/>
## 4) edit /etc/sudoers: "sudo EDITOR=nano visudo"
##      add <your_username> ALL=NOPASSWD: /usr/bin/cpufreq-set, /etc/acpi/eeepc/
##
echo "<openbox_pipe_menu>"
CPUmodel=$(cat /proc/cpuinfo | grep -m 1 "model name" | sed 's/.*: \|  \|(R)\|(TM)//g')
EEEPCmodel=$(cat /etc/conf.d/acpi-eeepc-generic.conf | grep -m 1 "EEEPC_MODEL" | sed 's/.*=\|"//g')
echo "<separator label=\"Asus EEEPC $EEEPCmodel $CPUmodel\"/>"

# CPU - cpufreq-utils #
	CPU0gov=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
	CPU1gov=$(cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor)
	availGOV=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors)
availFREQ=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies)
	CPUfreq=$(cat /proc/cpuinfo | grep -m 2 "cpu MHz" | sed 's/.*: \|.000//g')
	echo "<menu id=\"eeecontrol-cpu\" label=\"CPU: $CPU0gov/$CPU1gov - $CPUfreq Mhz\">"
	i=1
	for xgov in $availGOV
	do 
	if [ $xgov = "userspace" ]
	then
	j=1
	for xfreq in $availFREQ
	do
	xfreq=`expr $xfreq / 1000`
	echo "<item label=\"set: $xgov $xfreq Mhz\"><action name=\"Execute\"><execute>sudo cpufreq-set -c 0 -f $xfreq</execute></action><action name=\"Execute\"><execute>sudo cpufreq-set -c 1 -f $xfreq</execute></action></item>"
	let "j+=1"
	done
	else
	echo "<item label=\"set: $xgov\"><action name=\"Execute\"><execute>sudo cpufreq-set -c 0 -g $xgov</execute></action><action name=\"Execute\"><execute>sudo cpufreq-set -c 1 -g $xgov</execute></action></item>"
	let "i+=1"
	fi
	done
	echo "</menu>"
# CPU end #

# ACPI - acpi-eeepc-generic #
	statesDIR=/var/eeepc/states
	scriptsDIR=/etc/acpi/eeepc
	TPstate=$(cat $statesDIR/touchpad | sed 's/0/Off/' | sed 's/1/On/')
	echo "<item label=\"toggle Touchpad (now $TPstate) \"><action name=\"Execute\"><execute>sudo $scriptsDIR/acpi-eeepc-generic-toggle-touchpad.sh</execute></action></item>"
	BTstate=$(cat $statesDIR/bluetooth | sed 's/0/Off/' | sed 's/1/On/')
	echo "<item label=\"toggle Bluetooth (now $BTstate) \"><action name=\"Execute\"><execute>sudo $scriptsDIR/acpi-eeepc-generic-toggle-bluetooth.sh</execute></action></item>"
	CAMstate=$(cat $statesDIR/camera | sed 's/0/Off/' | sed 's/1/On/')
	echo "<item label=\"toggle Webcam (now $CAMstate) \"><action name=\"Execute\"><execute>sudo $scriptsDIR/acpi-eeepc-generic-toggle-webcam.sh</execute></action></item>"
	CARDstate=$(cat $statesDIR/cardr | sed 's/0/Off/' | sed 's/1/On/')
	echo "<item label=\"toggle Card Reader (now $CARDstate) \"><action name=\"Execute\"><execute>sudo $scriptsDIR/acpi-eeepc-generic-toggle-cardr.sh</execute></action></item>"
# ACPI end #
	echo "</openbox_pipe_menu>"
