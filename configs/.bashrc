

PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\nλ "

alias ls='ls --color=auto'
alias ll='ls -la'
alias gs='git status'
alias grep='grep --color'
alias c='clear'
export DBC_HOME=/dbc/sc-dbc2119/bcaulfield
export bora=$DBC_HOME/main-18q2/bora
export lsom=$bora/modules/vmkernel/lsom
export splinterdb=$bora/modules/vmkernel/wobtree/splinterdb


# setting up path
# lower it is the higher the priority
for pp in \
   /mts/git/bin \
   /build/apps/bin \
   /mts/git/tools/bin \
   /mts/git/vsan-tools/bin \
        /build/toolchain/lin64/python-2.7.9-openssl1.0.1t/bin \
        /build/toolchain/lin64/python-3.5.1-openssl1.0.2/bin \
        /build/toolchain/lin64/git-2.14.1-2/bin/ \
        /build/toolchain/lin64/gdb-7.5/bin/ \
   ${DBC_HOME}/usr/local/bin \
	/dbc/sc-dbc2119/bcaulfield/.local/bin \
; do
   PATH=$pp:${PATH}
done
export PATH

export P4CONFIG=.p4config
export HISTFILE=/tmp/$USER.bash_history


for a in /mts/git/bin/*; do alias `basename $a`=$a; done

# LS Colors 
LS_COLORS=$LS_COLORS:'di=1;36:' ; export LS_COLORS

alias vim='nvim'

export LD_LIBRARY_PATH=/dbc/sc-dbc2119/bcaulfield/.local/lib:
export MANPATH=$MANPATH:/dbc/sc-dbc2119/bcaulfield/.local/share/man


export EDITOR=nvim
export VISUAL=nvim
export GIT_EDITOR=nvim
