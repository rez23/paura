#!/bin/sh
########################################################################
# Copyright (c) 2018 Spartaco Amadei <spamadei@gmail.com>              #
#																																			 #
# This program is free software: you can redistribute it and/or modify #
# it under the terms of the GNU General Public License as published by #
# the Free Software Foundation, either version 3 of the License, or    #
# (at your option) any later version.                                  #
#                                                                      #
# This program is distributed in the hope that it will be useful,      #
# but WITHOUT ANY WARRANTY; without even the implied warranty of       #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #
# GNU General Public License for more details.                         #
#                                                                      #
# You should have received a copy of the GNU General Public License    #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.#
########################################################################
source  /usr/share/makepkg/*.sh
###
# Function
##
msg3(){
	local mesg=$1; shift
  printf "${GREEN}::${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}
helpfunct(){
  echo "Usage: "
	echo "paura [Option[suboption]] <package1> <package2>"
	echo ""
	echo "Options:"
	echo "-S | --Sync : Sync packages and nstall its"
	echo "-R | --Remove : Remove a package or some packages"
	echo "-Q | --Query : See installed packages"
	echo "-v | --version : See info about paura"
	echo "-h | --help : List of basics commands and its descriptions"
	echo "For more help see the man section of paura(3)"
}

paurainfo(){
	msg "p.AUR.a pacman AUR automatization"
	echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
	msg "v$version"
	msg "`pacman --version | grep -oP '(?=Pacman v).*'`"
	echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
	echo "For bugs reports or features request write to spamadei@gmail.com"
}

christmas_song(){
echo "ZWNobyAiZScgbmF0YWxlIHR1dHRvIHRhY2UiDQplY2hvICJjJ2UnIHF1YWxjb3NhIHN1bGxhIGJyYWNlIg0KZWNobyAibm9uIGUnIHBvbGxvIG5lIHRhY2NoaW5vIg0KZWNobyAicG9yY29kZGlvIGUnIGdlc3UnIGJhbWJpbm8i" | base64 -d | bash
}

cleanCahe(){
	printf "Clean paura pkg cache dir?(y/n):"
	read clean
	if [[ $clean == "y" ]]; then
		rm -rf ${clonedir}/*
	[[ $? == 0 ]] && echo "Done!"
	else
	exit 0
	fi
	printf "Clean pacman cache?(y/n):"
	read clean_pacman
	if [[ $clean_pacman == "y" ]]; then
		sudo pacman -Sc
		[[ $? == 0 ]] && echo "Done!"
	else
		exit 1
	fi
}

verboseCacheclean(){
cache_count=0
	printf "Scanning cache"
	printf "${outdate_pkg[$p1]}"
	while true; do
		echo -n "."
		sleep 1
	done &
	for i in `ls ${clonedir}/*`; do
		cachecount=$((++cache_count))
	done
	kill $!; trap 'kill $!' SIGTERM
	printf "                                                    Done!\n"
	if [[ ${cache_count} == 0 ]]; then
		echo "No packages in the cache foolder. All is clean"
		exit 0
	fi
		echo "The cache foolder contains ${cache_count} packages"
		printf "Clean the cache? [Y/n]"
		read  yesorno
		case ${yesorno} in 
			"y"|"")
			cleanCahe
			;;
			* )
			exit 0
			;;
		esac
		unset cache_count
}

ifwrong(){
	error "Something went wrong"
	echo "no package will be installed"
	exit 1
}
