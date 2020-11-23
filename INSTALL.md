
First, figure out the devices you want to use for your NDI streams.  You'll use two commands - one for video device, one for audio.

You'll want to start with audio to map your correct video capture device if you happen to have the multiple of the same device.

For example:

pi@raspberrypi:/proc/asound/MS2109 $ cat usbmixer 
USB Mixer: usb_id=0x534d2109, ctrlif=2, ctlerr=0
Card: MacroSilicon MS2109 at usb-0000:01:00.0-1.1, high speed
  Unit: 2
    Control: name="Digital In Capture Switch", index=0
    Info: id=2, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0


this: usb-0000:01:00.0-1.1

Will correlate down below the video usb device id in ().

You'll use: arecord -L get our hardware name (which is pretty standard)

Usually it'll be something along the lines of "plughw:CARD=###" Our case here:
plughw:CARD=MS2109,DEV=0
    MS2109, USB Audio
    Hardware device with all software conversions

(though maybe we can use direct hw: later, but for now...)

video:
v4l2-ctl --list-devices

Sample output:
pi@raspberrypi:~/yuri $ v4l2-ctl --list-devices
bcm2835-codec-decode (platform:bcm2835-codec):
	/dev/video10
	/dev/video11
	/dev/video12

bcm2835-isp (platform:bcm2835-isp):
	/dev/video13
	/dev/video14
	/dev/video15
	/dev/video16

UVC Camera (534d:2109): USB Vid (usb-0000:01:00.0-1.1):
	/dev/video0
	/dev/video1

UVC Camera (534d:2109): USB Vid (usb-0000:01:00.0-1.2):
	/dev/video2
	/dev/video3

Typically, you want the first device in the two video device list.  In the cases here with these cards, /dev/video0 and /dev/video2.   Note down one device at a time as we can only use one per config file.  

Now that you have your audio and video corresponding pieces, you'll want to plug them into the config generator. 

./config-gen.sh <your audio> <your video> <a description w/o special characters> <filename without extension>

The config gen will generate an xml file and a systemd service file to start on bootup.

Once that's all done, run the package installer

sudo ./pkg-install

The installer will install the necessary stuff for a headless install and also tweak a couple of settings related to the ndi.

Reboot the RPi once you have done this.


finally:

sudo ./config-install <filename>	 

This will install the systemd files and copy configs into /home/pi/yuri. 


