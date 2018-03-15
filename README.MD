<h1><strong>Paura</strong></h1>
<h2><strong>Pacman AUR Automatization</strong></h2>

paura is a pacman aur automatizer, based on auracle, that try to minimize as much as 
possible the user interact.

I have started this progect when pacaur was out of mantaining.

I needed an helper that should can search and downloads aur's packages and, as the 
same time, be able to auto compile and install packages. This was the 
porpouse with I have started the development of paura, to manage aur's packages minimizing as 
much as possible the user interacts. Since I needed to automatize some archlinux 
native operation, I preferred to write paura directly in bash, instead other 
languages,so to operate directly from system default shell.

Initially I don't had counted to pubblish paura,my initial idea was that of make an helper manage only my aur packages, however, with the passage of the time, the 
project became ever more mature and complete and finally, after some request from 
the few people to whom I had given paura, I have decide to share it.

So, ladies and gentleman... here it's for you, P.AUR.A, a pacman AUR automatizer 
that minimize user interacts and help you to utilize the aur repository.

<h4><strong>Features</strong></h5>

<strong>Recursive packages installatio</strong>

<strong>recognizing and processing both aur and core packages</strong>

<strong>automatic resolve and install aur dependencies from pkg/.SRCINFO</strong>

<strong>manage and clean cache directory</strong>

<strong>keeps upgraded aur packages</strong>S

and other, see paura(1) man page for more info.

<strong>INSTALL</strong>
If you want try paura,
simply clone the repository

<code>git clone https://github.com/rez23/paura.git</code>

<code>cd paura</code>

<code>cd makepkg</code>

<code>makepkg si</code>

Paura is based on auracle: https://github.com/falconindy/auracle

<h4><strong>Manually Install</strong></h4>

If you want install manually the code simply execute following command: 

<code>make install</code>
<h5><strong>USING THE PROGRAM </strong> </h5>

<code>paura [Optiono[suboption]] package1 package2 .. </code>

<strong>Option</strong>

-S : Sync

-R : Remove packages

-Q : See installed packages

-Sc : For clean cache

see the paura(1) man page for more info
<h4><strong>CONTACT</strong></h4>
For bug report and features request contact <email>spamadei@gmail.com</email>
