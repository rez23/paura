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
source  /usr/share/makepkg/util/message.sh
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
test_pkg(){
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

get_pkg(){
  if [[ -n ${aurpackage} ]]||[[ -n ${outdate_pkg} ]]; then
    VERSION=`auracle info ${aurpackage[$x]} | grep -oP '(?=Version).*'`
    pkgmsg "The next package will be installed from aur:"
    while [[ -n ${aurpackage[$x]} ]]; do
      printf "${aurpackage[$x]}" 
      printf "                          $VERSION\n"
      x=$((++x)) 
    done
    if [[ -n ${outdate_pkg} ]]; then
      pkgmsg "The next package will be upgrade from aur"
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

install_pkg(){
  install_list=( ${aurpackage[*]}
                   ${autdate_pkg[*]} )
  while [[ -n ${install_list[${o}]} ]]; do
    printf "${install_list[$o]} is going to be installed\n"
    printf "Do you want see the PKGBUILD frist? [Y/n]:" 
    read editpkg
    [[ ${editpkg} == "y" ]]||[[ ${editpkg} == "" ]] && pkgbuildedit ${clonedir}/${install_list[$o]}/PKGBUILD
    all_depends=(`cat ${clonedir}/${install_list[${o}]}/.SRCINFO|  awk '{if(/depends/) print $3}'`
                `cat ${clonedir}/${install_list[${o}]}/.SRCINFO|  awk '{if(/makedepends/) print $3}'`)
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
    msg "Installing ${install_list[$o]}:"
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
}

upgrade_pkg(){
 pacman -Su ${corepackage}
 echo $install_list
}

