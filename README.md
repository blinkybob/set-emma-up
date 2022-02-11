# set-emma-up
This shell script is intended to speed up the setup of my daily driver ( private and work laptop ).  
I normally use PopOS in the current version.  

Installations where user input is needed are at the end of the script, to keep it running more or less without user interaction

The script is a work in progress at the moment. 
Emma is the hostname of my Thinkpad, so the script is called set-emma-up ;-)

## usage
need to be executed with admin / root rights
```bash
cd 'your working directory'
git clone https://github.com/blinkybob/set-emma-up.git
cd set-emma-up
sudo bash setup.sh
```

## To Do
* logging
* suppress output to stdout except errors and status messages
* Check why balena-etcher is not installed properly after adding the repo
* add parameters so the user can choose between different installation groups (basic, work, game, whatever)
* check why reboot not working
* minimize needed user interaction
* 