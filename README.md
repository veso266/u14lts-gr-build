# u14lts-gr-build


This is a small script to demonstrate the build process for using the HackRF, RTL-SDR, and UHD with Gnuradio and Gqrx on Ubuntu 14.04 LTS.

The script is intentionally devoid of control flow and variable substitutions so as to illustrate the commands necessary for compilation from source, as if one were typing the commands into a terminal. Also, as this script will probably not be maintained, this will allow simple modification in the future by anyone who wishes to use it. 

This script enabled all options from all packages, with the exception of gr-osmosdr. Only the above mentioned SDR's are enabled. Feel free to add support for others and send a pull request, or just fork the project.

Instructions for uninstalling and updating are at the bottom of the script. 
