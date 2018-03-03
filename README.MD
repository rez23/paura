<h1><strong>Paura</strong></h1>

Pacman Aur Automatization

<h4><strong>Features</strong></h5>

<h7><strong>Recursive packages installation</strong> </h7> 
<code>paura -S package1 package2 package3</code>

<h7><strong>automatic recursive installation of aur dependencies</strong><h7>

<h7><strong>manage and clean cache directory</strong></h7>

<h3><strong>INSTALL</strong></h3>
If you want try paura,
simply clone the repository

<code>git clone https://github.com/rez23/PAURA.git</code>

<code>cd paura</code>

<code>cd makepkg</code>

<code>makepkg si</code>

<strong>NB</strong>

Paura is based on auracle, so you need to have it alredy installed on your computer

<h4><strong>Manually Install</strong></h4>

If you want to build manually the code simply execute following command: 

<code>make install</code>
<h5><strong>USING THE PROGRAM </strong> </h5>

<code>paura [Optiono[suboption]] package1 package2 .. </code>

<strong>Option</strong>

-S : Sync

-R : Remove packages

-Q : See installed packages

-Sc : For clean cache

see the paura(1) man pagr for more info
<h4><strong>CONTACT</strong></h4>
For bug report and features request contact <email>spamadei@gmail.com</email>
