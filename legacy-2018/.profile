# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# User Aliases

#General
dotfiles=~/Documents/dotfiles/
alias restart-network="sudo service network-manager restart"
alias vim="vim -u $dotfiles/.vimrc"
alias vi="vim"
zshrc=$dotfiles/.zshrc
alias profile='vi $dotfiles/.profile && source ~/.profile'
alias zshrc='vi $dotfiles/.zshrc && source $dotfiles/.zshrc'
function fcd () { cd $@ || mkdir $@ && cd $@; }
alias vimrc='vi $dotfiles/.vimrc'
alias vundle='vi $dotfiles/.vimrc && vim +PluginInstall'
alias p='ping 8.8.8.8 | lolcat'
function drm () { sudo rm -dR $@; }
alias internet='speedtest-cli && p'
alias termbin='nc termbin.com 9999'
i2config=$dotfiles/.config/i3/config
alias i3config='vi $dotfiles/.config/i3/config'
#function wifi () { nmcli dev wifi list  | awk ' {print $1} ' | dmenu | xargs nmcli device wifi connect}
alias rnet='sudo service NetworkManager restart && sudo service NetworkManager status'
function wificonnect() { nmcli --ask device wifi connect $@; }
alias wifilist='nmcli device wifi list'
# function rmswp () { rm .$@.swp; }

#Cassa
cassa=~/Documents/projects/cassamobile_be/
alias cassa='ranger $cassa' 
function cassapush () { cassa && git commit -a -m "$@" && git push origin Development && cassaconnect; }
cassaserver=~/Documents/servers/cassa/
alias cassaserver='cd $cassaserver'
alias cassaconnect='sudo ssh -i $cassaserver/staging.pem ubuntu@staging.cassa.io'
function cassapush () { cassa && git commit -a -m $@ && git push origin Development && cassaconnect; }
function chromepdf () { chromium-browser --headless --disable-gpu --print-to-pdf $@; }
alias edit='vi $cassa/server.js'

#Firstnanny
nannyserver=~/Documents/servers/firstnanny/
alias nannyconnect='sudo ssh -i $nannyserver/ssh.pem ubuntu@ec2-35-154-180-127.ap-south-1.compute.amazonaws.com'

#Personal
alias connect='sudo ssh -i ~/Documents/servers/personal/myssh.pem ubuntu@52.14.93.146'
alias bashify='$(which bash)'

#Music
alias music='ranger ~/Music'
alias mp3='cd ~/Music/ && youtube-dl --embed-thumbnail --extract-audio --audio-format mp3 -a unsorted/links.txt -o "~/Music/unsorted/%(title)s.%(ext)s" && cat unsorted/links.txt >> downloaded.txt && truncate -s 0 unsorted/links.txt'
alias songs='vi ~/Music/unsorted/links.txt'

#General Development
alias ws='webstorm'
projects=~/WebstormProjects
servers=~/Documents/servers
alias projects='ranger $projects'
alias servers='ranger $servers'
alias Test='cd ~/Test/'
#alias c='Test && chromepdf index.html && xdg-open output.pdf'
#alias r='Test && rm output.pdf'
#alias rc='r && c'
# alias mysql='sudo mysql --defaults-file=/etc/mysql/debian.cnf -A'
alias mysqlconfig='sudo vi /etc/mysql/debian.cnf'
alias test='cd ~/test/'
alias json='python -m json.tool'
alias mongostart='sudo service mongod start'
alias headless-chrome='chromium-browser --interpreter none --headless --disable-gpu  --disable-translate  --disable-extensions  --disable-background-networking  --safebrowsing-disable-auto-update  --disable-sync  --metrics-recording-only  --disable-default-apps  --no-first-run  --mute-audio  --hide-scrollbars  --remote-debugging-port=9222'
alias fountane='psql -d fountane -U paul'

#Nsmiles
nserver=~/Documents/servers/nsmiles
alias nserver='ranger $nserver'
ndev='nsmiles@35.226.235.202'
ndep='nsmiles@35.225.165.32'
alias ndev='sudo ssh -i $nserver/nsmilesdev.pem nsmiles@35.226.235.202'
alias ndep='sudo ssh -i $nserver/nSmilesLive.pem nsmiles@35.225.165.32'
#alias enterprisebe='fuser -k 3214/tcp; cd $projects/enterprise_backend/ && node index.js'
#alias happyexams='fuser -k 3000/tcp; cd $projects/happyexams/ && npm start'
#alias apiserver='fuser -k 1337/tcp; cd $projects/nsmiles-api-server/ && node app.js'
#alias webapp='fuser -k 3000/tcp; cd $projects/nsmiles.com-websiteapp/ && npm start'
#alias nsmiles='enterprisebe & sleep 2 && guake --new-tab=2 --execute-command="apiserver" & sleep 2 &&  guake --new-tab=3 --execute-comand="webapp"'

#Fantasy Field
uipep=~/Documents/servers/uipep
ffield=~/Documents/servers/fantasy-field
alias uipep='ranger $uipep'
alias ffield='ranger $ffield'
fdemo1='ubuntu@ec2-13-59-141-35.us-east-2.compute.amazonaws.com'
fdemo='ubuntu@ec2-13-58-152-22.us-east-2.compute.amazonaws.com'
alias fdemo1='sudo ssh -yi $uipep/uipep.pem $fdemo1'
alias fdemo='sudo ssh -i $ffield/fantasy-field.pem $fdemo'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

fortune -s


