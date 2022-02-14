###############
# Testing Tools
###############
#commix
alias commix='python /home/michi/tools/commix/commix.py'
#enum4linux aufrufen
alias enum4linux='perl /home/michi/tools/enum4linux/enum4linux.pl'

#nikto
alias nikto='perl /home/michi/tools/nikto/program/nikto.pl'

#testssl
alias testssl='bash /home/michi/tools/testssl.sh/testssl.sh'
# testssl Docker
alias docker-testssl='sudo docker run -ti drwetter/testssl.sh'

#######################
#Public IPs
alias myip6='curl -6 ifconfig.co'
alias myip4='curl -4 ifconfig.co'
#alias myip4='dig +short myip.opendns.com @resolver1.opendns.com'

#mount command better readable
alias mount='mount | column -t'

#wget resume by default
alias wget='wget -c'

#grep and ls beautify
alias grep='grep --color=auto'
alias ls='ls --color=auto'


# alias for changing in routerlab directory
alias cpelab='cd /home/michi/sec/1_Project/CPE/cpelab/'
alias cpelab-git='cd /home/michi/sec/1_Project/CPE/cpelab/Labor/gitlab.cpelab.de/'

#spice connection routerlab vm 333 debian
alias cpe-spice-333='bash /home/michi/sec/1_Project/CPE/cpelab/Labor/gitlab.cpelab.de/snippets/spice-v01.sh -u michael@pve -p <PW> 333 kermit'

#spice connection routerlab vm 334 kali
alias cpe-spice-334='bash /home/michi/sec/1_Project/CPE/cpelab/Labor/gitlab.cpelab.de/snippets/spice-v01.sh -u michael@pve -p <PW> 334 kermit'

### vpn metric changes ###
alias metwifi='echo "setting metric for wifi vpn shit..." && sudo ifmetric wlp3s0 45'
alias metlan='echo "setting metric for lan vpn shit..." && sudo ifmetric enp0s31f6 45'

### change batcat to bat
alias bat='batcat'
