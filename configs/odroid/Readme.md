# armbian odroid c4 bullseye  

## armbian-config  

* change kernel to 5.10 because of i2c support
* recompile dtb removing references to vrtc
* freeze

## rtc

* armbian-add-overlay pcf8563.dts  
* **todo** - hwclock timedatectl details
* edit /lib/udev/hwclock-set comment first if
* uninstall/disable fake-hwclock


## lcdproc

* git clone from github
* apt install build-essential libusb-dev libncurses-dev pkg-config
* sh autogen.sh
* ./configure --enable-drivers=curses,hd44780,linux_input
* **todo** - document lcd wiring to i2c1

## infrared remote

* apt install ir-keytable 
* check with ir-keytable -t
* update LCDd.conf

## leds

### for testing without sudo  
* sudo groupadd leds
* sudo usermod -aG leds peter
* sudo cp 60-leds.rules /etc/udev/rules.d/

### definition for traffic light on GPIOX_14,_15,_6  

* sudo armbian-add-overlay gpio-leds.dts

### add module for timer trigger (blinking)

* sudo modprobe ledtrig-timer
* add to /etc/modules-load.d/modules.conf

## automount usb

* sudo mkdir /mnt/usb
* add to fstab 

    /dev/sda1  /mnt/usb  vfat  rw,users,umask=0,noauto,nofail,x-systemd.automount,x-systemd.idle-timeout=2,x-systemd.device-timeout=2 0 0  
