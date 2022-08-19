# Source Micron standard .bashrc file
#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
source /cde/prod/SM/setup/.bashrc.cde 
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# For help, go to webpage below:
#  http://rndweb.micron.com/tools/enviro/designEnv/
#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

br(){
buildreport -rnl $1 $* | grep -v " / "
}

path(){
readlink -f $1
}

set_p4client(){
    cmd_str=$(cat .p4config)
    export $cmd_str
}

nvim(){
    PATH=$PATH:/runs/simrun_tav/libs/bin LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/runs/simrun_tav/libs/lib/ /runs/simrun_tav/libs/bin/nvim $*
}

gnvim(){
    PATH=$PATH:/runs/simrun_tav/libs/bin /runs/simrun_tav/libs/bin/goneovim $* > /dev/null 2>&1 & disown
}

vim8(){
    PATH=$PATH:/runs/simrun_tav/libs/bin LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/runs/simrun_tav/libs/lib/ /runs/simrun_tav/libs/bin/vim $*
}

rg(){
    /runs/simrun_tav/libs/bin/rg $*
}

dolphin(){
     /usr/bin/dolphin $* > /dev/null 2>&1 &
}

find_my_usage(){
    find $1 -maxdepth $2 -user $USER -type d ! -path $1 -exec du -csh {} + | sort -hr
    if [ $? -eq 0 ]; then
        echo OK
    else
        echo FAIL
        echo "Usage: find_my_usage <path to search in> <depth to search till>"
        exit 1
    fi
}

mgitstat(){
    find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git status --long && echo)' \;
}

multidu(){
    fail=0
    if [ -d $1 ]; then
        echo "Dir to Search: $1"
    else
        echo "$1 is not a Dir"
        fail=1
    fi
    if [ -f $2 ]; then
        echo "Output file  : $2"
    else
        echo "$2 is not a file"
        fail=1
    fi
    if [[ $3 -gt 0 ]]; then
        echo "Depth        : $3"
    else
        echo "$3 is not a valid depth"
        fail=1
    fi
    if [ $fail -eq 0 ]; then
        echo OK
    else
        echo FAIL
        echo "Usage: multidu <dir to profile contents of> <output log filepath> <depth to search>"
        exit 1
    fi
    echo "Press Enter to proceed"
    read
    echo "" >| $2
    for dir in $(find $1 -maxdepth $3) 
    do 
        du -sh $dir 1>> $2 2>/dev/null &
    done
}


get_ignore(){
    scp hyldlog4:/runs/simrun_tav/tav_dev/.config/.ignore .
}

ftmux() {
    tmux -S $(ls -d -1 ~/sockets_tmux/* | fzf -m) a
}

fbr() {
    buildreport -rnl $(ls -ltd log*/ | fzf --no-sort) $*
}

get_rand_hash() {
    export RANDOM_HASHCODE=$(openssl rand -hex 20)
}

vsim_snap() {
    mkdir snapshots > /dev/null 2>&1
    get_rand_hash && vsim -s snapshots/${RANDOM_HASHCODE}.tar $*
}

update_my_term(){
    sh -c "$(curl -fsSL https://bitbucket.micron.com/users/pbharati/repos/term_nvim_setup/raw/vim_setup.sh\?at\=refs%2Fheads%2Fmaster )" ""
}

tb_last_modified(){
    for dir in $(find $1 -mindepth 1 -maxdepth 1 -type d ! -wholename "$1/log*"); do find $dir -type f -cmin -$2; done
}


if [ -z $ZSH_VERSION ]; then
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
    alias cmdline_long="export PS1='\[\033[0;35m\][\!:\h \[\033[0;33m\]\w]\[\033[00m\]: '"
    alias cmdline_short="export PS1='\[\033[0;35m\][\!:\h \[\033[0;33m\]\W]\[\033[00m\]: '"
fi


alias ag='/runs/simrun_tav/libs/bin/ag --hidden'
alias ctags="/runs/simrun_tav/libs/bin/ctags"
alias curr_cl="p4 changes -m1 ./...#have"
alias fugitive="nvim -c :Git"
alias glog="git log --graph --decorate --oneline --simplify-by-decoration"
alias glog_full="git log --graph --decorate --oneline"
alias lsof=/usr/sbin/lsof
alias reset_term="env -i HOME="$HOME" bash -l "
alias djinji="/runs/simrun_tav/tav_dev/jira_djinji/djinji/run_djinji.sh"
alias djinji_cli="/runs/simrun_tav/tav_dev/jira_djinji/djinji/run_djinji_cli.sh"
alias bvim="vim --noplugin "
alias lsfdash="lsfdash > /dev/null 2>&1 & disown"
alias p4v="p4v & disown"
alias lst="ls -ltrah"
alias ll="ls -lah"
export P4EDITOR=/usr/bin/vim
export PATH=$PATH:$HOME/.local/bin/:/runs/simrun_tav/tav_dev/bin
export TERM=screen-256color
export VISUAL=/usr/bin/vim
export EDITOR="$VISUAL"
