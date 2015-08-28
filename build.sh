#!/bin/bash

## While this script could be cleaned up alot, it is intentionally left verbose
## to make it easy to edit in the future and easy to see each step, exactly as 
## one may type it into the terminal.

## I used -4 with make as its a fairly safe bet these days... for faster build, 
## run the following and replace 4 with the number of cores you have
#cat /proc/cpuinfo | grep "core id" | wc -l

## Install dependencies... not all of these 
## may be strictly necessary but they wont hurt to be there
## these were all found by running cmake and adding packages till it was happy. 
sudo apt-get install cmake libusb-1.0-0-dev python-cheetah libboost-all-dev doxygen libudev-dev python-sphinx python-numpy qt4-qmake libgsl0-dev libcppunit-dev swig libqt4-dev libfftw3-3 libfftw3-single3 libfftw3-dev python-thrift python-wxgtk2.8 python-guiqwt python-qwt3d-qt4 libsdl-dev libzmq-dev libcomedi-dev build-essential git texlive-latex-base

## Make a temporary directory and change directory into it
mkdir -p SDR && cd SDR

## Clone all the projects we will need.
## RTLSDR
git clone git://git.osmocom.org/rtl-sdr.git rtlsdr/
## UHD
git clone https://github.com/EttusResearch/uhd uhd/
## Hackrf
git clone https://github.com/mossmann/hackrf hackrf/
## Gnuradio
git clone https://github.com/gnuradio/gnuradio gnuradio/
## gr-iqbal
git clone git://git.osmocom.org/gr-iqbal iqbal/
## gr-osmosdr
git clone git://git.osmocom.org/gr-osmosdr osmosdr/
## Gqrx
git clone https://github.com/csete/gqrx gqrx/

## Build and install rtlsdr, the -D flags enable support
## for automagic plug and play
cd rtlsdr/
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON
make -j 4
sudo make install
cd ../../

## Build and install hackrf
cd hackrf/host
mkdir build
cd build
cmake ../
make -j 4
sudo make install
cd ../../../

## Build and install UHD this should enable support
## for all current ettus devices
cd uhd/host
mkdir build
cd build
cmake ../ -DENABLE_E100=ON -DENABLE_E300=ON
make -j 4
sudo make install
cd ../../../

## If you have other SDR projects add them here

## Build and install gnuradio. This one will take a bit. 
cd gnuradio
git submodule init
git pull --recurse-submodules=on
git submodule update
mkdir build
cd build
cmake ../
make -j 4
sudo make install
cd ../../

cd iqbal
git submodule init
git pull --recurse-submodules=on
git submodule update
mkdir build
cd build
cmake ../
make -j 4
sudo make install
cd ../../

cd osmosdr
mkdir build
cd build
cmake ../
make -j 4
sudo make install
cd ../../

cd gqrx
mkdir build
cd build
qmake ../
make -j 4
sudo make install
cd ../../

## This is necessary to load UHD firmware
## sudo /usr/local/lib/uhd/utils/uhd_images_downloader.py

## This is necessay to use UHD as a normal user
## sudo cp uhd/host/utils/uhd-usrp.rules /etc/udev/rules.d/

## This loads all three SDRs udev rules active, which allows them
## to be used without root
sudo udevadm control --reload-rules

## This makes sure various programs can find their correct libraries.
sudo ldconfig

## This installs GNU Radio Companion Icon set
./usr/local/libexec/gnuradio/grc_setup_freedesktop install


## This makes sure various programs can find their correct libraries.
sudo ldconfig

# Install GQRX Launcher Icon
sudo mkdir -p /usr/local/share/gqrx/freedesktop
cd gqrx/icons
sudo cp gqrx.svg /usr/local/share/gqrx/freedesktop
sudo sh -c 'echo "[Desktop Entry]\nVersion=1.0\nType=Application\nName=GQRX\nExec=gqrx\nCategories=Development;\nIcon=/usr/local/share/gqrx/freedesktop/gqrx.svg" >> gqrx.desktop'
sudo desktop-file-install gqrx.desktop


## TO uninstall uncomment (remove the # mark below) and paste into a terminal 
## in the same directory as this script
#cd SDR
#cd gqrx/build && sudo make uninstall && cd ../../
#cd osmosdr/build && sudo make uninstall && cd ../../
#cd iqbal/build && sudo make uninstall && cd ../../
#cd gnuradio/build && sudo make uninstall && cd ../../
#cd uhd/host/build && sudo make uninstall && cd ../../../
#cd hackrf/host/build && sudo make uninstall && cd ../../../
#cd rtlsdr/build && sudo make uninstall && cd ../../
#sudo ldconfig


## To update: Run the uninstall above, then uncomment and paste as above
#cd SDR
#cd rtlsdr/build
#rm -rf ../build/*
#git pull
#cmake ../ -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON
#make -j 4
#sudo make install
#cd ../../

#cd hackrf/host/build
#rm -rf ../build/*
#git pull
#cmake ../
#make -j 4
#sudo make install
#cd ../../../

#cd uhd/host/build
#rm -rf ../build/*
#git pull
#cmake ../
#make -j 4
#sudo make instal
#cd ../../../

#cd gnuradio/build
#rm -rf ../build/*
#git pull --recurse-submodules=on
#git submodule update
#cmake ../
#make -j 4
#sudo make install
#cd ../../

#cd iqbal/build
#rm -rf ../build/*
#git pull --recurse-submodules=on
#git submodule update
#cmake ../
#make -j 4
#sudo make install
#cd ../../

#cd osmosdr/build
#rm -rf ../build/*
#git pull
#cmake ../
#make -j 4
#sudo make install
#cd ../../

#cd gqrx/build
#rm -rf ../build/*
#git pull
#qmake ../
#make -j 4
#sudo make install
#cd ../../

#sudo /usr/local/lib/uhd/utils/uhd_images_downloader.py
#sudo udevadm control --reload-rules
#sudo ldconfig


