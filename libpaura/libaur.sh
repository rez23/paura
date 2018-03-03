#!/bin/sh
# Copyright (c) 2018 Spartaco Amadei <spamadei@gmail.com>

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
BAR="#"
source /usr/share/makepkg/*.sh
get_pkg(){
	if [[ -n ${corepackage} ]]; then
	msg "Downloading and installing core packages" 
	sudo pacman -S ${corepackage}
	fi
	if [[ -n ${aurpackage} ]]||[[ -n ${outdate_pkg} ]]; then
		VERSION=`auracle info ${aurpackage[$x]} | grep -oP '(?=Version).*'`
		msg "Looking in aur" 
		msg "The next package will be installed from aur:"
		while [[ -n ${aurpackage[$x]} ]]; do
			printf "${aurpackage[$x]}" 
			printf "                          $VERSION\n"
			x=$((++x)) 
		done
		if [[ -n ${outdate_pkg} ]]; then
			msg "The next package will be upgrade from aur"
			auracle sync
		fi
		printf "Continue? [Y/n]:"
		read reponse
		if [[ $reponse == "y" ]]||[[ ${reponse} == '' ]]; then
			cd ${clonedir}
			msg "Downloading package:"
			while [[ -n ${aurpackage[$p]} ]]; do
				printf "${aurpackage[$p]}"
				while true;do 
				echo -n "."
				sleep 1
				done &
				auracle download -r ${aurpackage[$p]}  &>/dev/null
				kill $!; trap 'kill $!' SIGTERM
				printf "                                                    Done!"
				echo
				p=$((++p))
			done
			while [[ -n ${outdate_pkg[$p1]} ]]; do
				while true; do
					printf "${outdate_pkg[$p1]}"
					while true; do
					echo -n "."
					sleep 1
					done &
					auracle download -r ${outdate_pkg[$p1]} &>/dev/null
					kill $!; trap 'kill $!' SIGTERM
				printf "                                                    Done!"
				echo
				done
				x1=$((++p1))
			done
		else 
				exit 0
		fi
	fi
}

process_pkg(){
	cd ${clonedir}
  install_pkg
  if [[ $? == 0 ]]; then
		msg "All packages are installed sucessfully"
	fi
}
