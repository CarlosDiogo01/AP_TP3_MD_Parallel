#! /usr/bin/env bash

#
#	install.sh - Installs neccesary components required for gengraph
#	Copyright (C) 2015 Jaydeep Dhrangdhariya <jaydeep.gajjar90@gmail.com>
#	
#	This program is free software; you can redistribute it and/or
#	modify it under the terms of the GNU General Public License
#	as published by the Free Software Foundation; either version 2
#	of the License, or (at your option) any later version.
#	
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#	
#	You should have received a copy of the GNU General Public License
#	along with this program; if not, write to the Free Software
#	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#

PROGRAM_NAME=gengraph

check_for_shell() {
	if [ "$BASH" != "/bin/bash" ]; then
		echo
		echo "\Script is not running with bash shell. Aborting !!!"
		echo
		exit
	fi
}

check_for_root_user() {
	if [[ $EUID -ne 0 ]]; then
		echo
		echo "This script must be run as root" 1>&2
		echo
		exit -1
	fi
}

check_dependancy() {
	local program=$1
	echo "Checking for $program..."
	local exit_on_not_found=$2
	which $program > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		if [ $exit_on_not_found == "yes" ]; then
			echo "$program not found. Aborting !!!"
			echo ""
			exit -2
		else
			echo "$program not found."
		fi
		return 1
	fi
	return 0
}

install_program() {

	check_dependancy gcc "yes"
	check_dependancy perl "yes"
	check_dependancy git "yes"
	check_dependancy dot "no"

	if [ $? -ne 0 ]; then
		echo "Downloading and installing dot..."
		sudo apt-get -y install graphviz > /dev/null 2>&1
		check_dependancy dot "yes" > /dev/null 2>&1
	fi

	check_dependancy egypt "no"
	if [ $? -ne 0 ]; then
		cd /tmp
		echo "Downloading and installing egypt..."
		rm -rf egypt
		git clone git://github.com/lkundrak/egypt.git > /dev/null 2>&1
		if [ $? -ne 0 ]; then
			echo "Can not download egypt."; echo
			exit -3
		fi

		cd egypt
		if [ $? -ne 0 ]; then
			echo "Can not install egypt - (err - 1)"; echo
			exit -4
		fi

		perl Makefile.PL > /dev/null 2>&1
		if [ $? -ne 0 ]; then
			echo "Can not install egypt - (err - 2)"; echo
			exit -4
		fi

		make > /dev/null 2>&1
		if [ $? -ne 0 ]; then
			echo "Can not install egypt - (err - 3)"; echo
			exit -4
		fi
			
		make install > /dev/null 2>&1
		if [ $? -ne 0 ]; then
			echo "Permission Denied to install egypt. Try again with sudo."
			exit -4
		fi
	fi
	
	cd $CUR_DIR
	
	echo "Installing $PROGRAM_NAME..."
	
	cp $PROGRAM_NAME /usr/local/bin
	
	echo
	echo "Installation completed successfully."; echo
}

uninstall_program() {
	echo "Uninstalling dot..."
	sudo apt-get -y remove graphviz > /dev/null 2>&1
	echo "Uninstalling egypt..."
	sudo rm -rf /usr/local/bin/egypt
	echo "Uninstalling $PROGRAM_NAME..."
	sudo rm -rf /usr/local/bin/gengraph
	echo
	echo "Uninstallation completed successfully."; echo
}

CUR_DIR=$(pwd)

check_for_shell
check_for_root_user
echo

if [ $# -eq 0 ]; then
	install_program
elif [[ $# -eq 1 && $1 == "-u" ]]; then
	uninstall_program
else
	echo "[USAGE] : sudo $0"
	echo "          (Run above command to install.)"; echo
	echo "          sudo $0 -u"
	echo "          (Run above command to uninstall.)"; echo
fi
