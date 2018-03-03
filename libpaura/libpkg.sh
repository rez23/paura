#!/bin/sh

########################################################################
# Copyright (c) 2018 Spartaco Amadei <spamadei@gmail.com>              #
#                                                                      #
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
####
# Array
###
declare -a corepackage
declare -a aurpackage
declare -a notfoundpkg
declare -a autdate_pkg
declare -a install_list
declare -a all_depends

###
# Function
##
testpkg(){
	while [[ -n ${package[$n]} ]]; do
		if (pacman -Si ${package[$n]} &>/dev/null); then
			corepackage[$a]=${package[$n]}
			a=$((++a))
		elif  (auracle info ${package[$n]} &>/dev/null); then
			aurpackage[$b]=${package[$n]}
			b=$((++b))
		else 
			notfoundpkg[$c]=${package[$n]}
			c=$((++c))
		fi
		n=$((++n))
	done
	[[ $sysupgrade == 1 ]] && autdate_pkg=(`auracle sync --quiet`)
	unset n a b c
}

install_pkg(){
	set -x
	install_list=(${aurpackage[*]}
								${autdate_pkg[*]})
	while [[ -n ${install_list[${o}]} ]]; do
		source ${clonedir}/${install_list[${o}]}/PKGBUILD
		all_depends=(${depends[*]}
								${makedepends[*]})
			if [[ -n ${all_depends} ]]; then
					msg "installing ${install_list[$o]} dependencies"
					while [[ -n ${all_depends[$n]} ]]; do
					if [[ -d ${clonedir}/${all_depends[$n]} ]]; then
						cd ${clonedir}/${all_depends[$n]}
						makepkg -si
						[[ $? != 0 ]] && exit 1
					fi
					n=$((++n))
				done
			fi
		msg "Starting ${install_list[$o]} installation"
		if [[ -d ${clonedir}/${install_list[$o]} ]]; then
			cd ${clonedir}/${install_list[$o]}
		else
			ifwrong
			exit 1
		fi
		makepkg -si
		[[ $? != 0 ]] && exit 1
		o=$((++o))
		unset all_depends
	done
	unset o n 
	set +x
}

upgrade_pkg(){
 pacman -Su ${corepackage}
 echo $install_list
}
