

PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\nλ "

alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'

alias ls='ls --color=auto'
alias ll='ls -la'

alias grep='grep --color'

export PATH=/dbc/sc-dbc2119/bcaulfield/.local/bin:/build/apps/bin:/build/trees/bin:/build/trees/main/build/bin:/mts/git/tools/bin:$PATH
export P4CONFIG=.p4config
export HISTFILE=/tmp/$USER.bash_history

export DBC_HOME=/dbc/sc-dbc2119/bcaulfield
export bora=$DBC_HOME/main-18q2/bora
export splinterdb=$bora/modules/vmkernel/wobtree/splinterdb


for a in /mts/git/bin/*; do alias `basename $a`=$a; done

# LS Colors 
LS_COLORS=$LS_COLORS:'di=1;36:' ; export LS_COLORS

cd $DBC_HOME
alias vim='nvim'

export PATH=$PATH:/dbc/sc-dbc2119/bcaulfield/bin/clangd_10.0.0/bin
export LD_LIBRARY_PATH=/dbc/sc-dbc2119/bcaulfield/.local/lib:
export MANPATH=$MANPATH:/dbc/sc-dbc2119/bcaulfield/.local/share/man
