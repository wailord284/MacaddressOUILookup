#!/bin/bash
echo "Enter a path to your list of macaddresses"
read -e -r macaddress
#Loop the OUI information and compare it to nmap
for mac in $(cat "$macaddress" | sed 's/\.//g' | sed 's/\://g' | sed 's/\-//g' | sed '/^[[:space:]]*$/d' | sed 's/^[[:blank:]]*$/NoMac/' | sed 's/ //g' | cut -c1-6) ; do
	if [ "$mac" == "NoMac" ] ; then
		echo "$mac" >> MacVendor.txt
	else
		#Add a \n to make sure everything gets its own line
		IFS=$'\n' allVendors+=($(grep -i "$mac" /usr/share/nmap/nmap-mac-prefixes))
	fi
done
#Remove the OUI mac in the front
for vendor in "${allVendors[@]}" ; do
	#Output the vendor to a txt file
	echo "$vendor" | cut -d" " -f2- >> macvendors.txt
done
