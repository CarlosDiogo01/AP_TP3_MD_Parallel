==============
 INTRODUCTION
==============

The "gengraph" is a bash script which generates static function call
graph for C source code.

The "install.sh" is a bash script which installs all necessory 
components required to run "gengraph". It additionally copies the
the "gengraph" to /usr/local/bin.

=================================
 INSTALLATION AND UNINSTALLATION
=================================

git clone git://github.com/jaydeepd/gengraph.git
cd gengraph
chmod +x install.sh
sudo ./install.sh

cd temp-directory/example

#Command to generate any call-graph from *.c files
gengraph -o final -t png *.c

final.png generated


To uninstall, run following command.

sudo ./install.sh -u

(NOTE: uninstalling will also remove graphviz component from your system
       , if you want to uninstall "gengraph" then, simply remove sript
       from /usr/local/bin directory.)
       
=======
 USAGE
=======

#Command to generate any call-graph from *.c files
gengraph -o final -t png *.c

Run gengraph -h for help.


