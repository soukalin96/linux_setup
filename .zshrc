# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.

source ~/.bashrc

if [ -n "$(echo $ZSH_VERSION)" ]; then
ZSH_THEME="candy" # set by `omz`
   export ZSH="$HOME/.oh-my-zsh"
   export PATH="$HOME/local/bin:$PATH"
   source $ZSH/oh-my-zsh.sh
   DISABLE_AUTO_TITLE="true"
   # ENABLE_CORRECTION="true"
   ZSH_DISABLE_COMPFIX="true"
   MODE_INDICATOR="%F{yellow}+%f"
   VI_MODE_SET_CURSOR=true
   
   plugins=(vscode zsh-interactive-cd)
   export BAT_THEME="gruvbox-dark"


   short=' %F{14}[%1~] %{$fg[red]%}$(git_current_branch)-> '
   long='%(?.%F{green}√.%F{red}?%?)%f %B%m: %F{240}%~ %{$fg_bold[blue]%}$(git_current_branch)
%f%b%# '
   export PS1=$short
   export FZF_DEFAULT_COMMAND="fd"
   export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
   export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
   export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --info inline 
   --header-first --cycle --border sharp 
   --preview-window right:75% --bind shift-up:preview-top,shift-down:preview-bottom,shift-right:preview-down,shift-left:preview-up 
   --color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
   --color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B"
   # Use ~~ as the trigger sequence instead of the default **
   export FZF_COMPLETION_TRIGGER='~~'
   export FZF_CTRL_T_OPTS="--prompt 'All> ' \
         --header 'CTRL-D: Directories / CTRL-F: Files' \
         --bind 'ctrl-d:change-prompt(Directories> )+reload(fd -t d)' \
         --bind 'ctrl-f:change-prompt(Files> )+reload(fd -t f)' \
         --preview 'bat --color=always --style=numbers --line-range=:500 {}' \
         --layout=reverse -e --no-sort --height 60%"

   _gen_fzf_default_opts() {
#   local base03="234"
#   local base02="235"
#   local base01="240"
#   local base00="241"
#   local base0="244"
#   local base1="245"
#   local base2="254"
#   local base3="230"
#   local yellow="136"
#   local orange="166"
#   local red="160"
#   local magenta="125"
#   local violet="61"
#   local blue="33"
#   local cyan="37"
#   local green="64"
  # Uncomment for truecolor, if your terminal supports it.
  local base03="#002b36"
  local base02="#073642"
  local base01="#586e75"
  local base00="#657b83"
  local base0="#839496"
  local base1="#93a1a1"
  local base2="#eee8d5"
  local base3="#fdf6e3"
  local yellow="#b58900"
  local orange="#cb4b16"
  local red="#dc322f"
  local magenta="#d33682"
  local violet="#6c71c4"
  local blue="#268bd2"
  local cyan="#2aa198"
  local green="#859900"

  # Comment and uncomment below for the light theme.

  # Solarized Dark color scheme for fzf
#   export FZF_DEFAULT_OPTS="
#     --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
#     --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
#   "
  ## Solarized Light color scheme for fzf
  export FZF_DEFAULT_OPTS="
   --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
   --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
  "
}
# _gen_fzf_default_opts

   [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


   HISTFILE=~/.zsh_history
   HISTSIZE=10000
   SAVEHIST=10000
   setopt appendhistory

   bindkey '^j' session_jumper
   bindkey "^[[1~" beginning-of-line
   bindkey "^[[H" beginning-of-line
   bindkey "^[[4~" end-of-line
   bindkey "^[[F" end-of-line
   bindkey "^[[3~" delete-char
   bindkey '^g' goto
   bindkey '^l' llog
   bindkey '^f' fzfsearch

   bindkey '^p' cpth

   bindkey '\e[1;5C' getin
   bindkey '\e[1;5D' getout
   bindkey '\e[1;5B' getall
   bindkey '^h' _complete_help
   bindkey "^[[1;3C" forward-word
   bindkey "^[[1;3D" backward-word

   alias count='fd . -t f | wc -l'
   alias x="exit"
   alias e="nvim ~/.zshrc"
   alias r="source ~/.zshrc"
   alias c="clear"
   alias h="history -10"      # last 10 history commands
   alias hc="history -c"      # clear history
   alias hg="history | grep " # +command
   alias cpv='rsync -ah --info=progress2'
   alias bg=/home/soukaling/bat-extras/bin/batgrep
   alias bd=/home/soukaling/bat-extras/bin/batdiff
   alias tmux=/home/soukaling/local/bin/tmux
  
   # alias vsim=vsim_check

   gf(){
       selectbranch=($(git branch | rg soukalin | rg -v "^\*" | fzf-tmux -p 50%,50%))
       if [ -n "$selectbranch" ]; then
         git checkout $selectbranch
       fi
   }

   session_jumper() {
    tmux list-sessions -F '#{?session_attached,,#{session_name}}' |\
    sed '/^$/d' |\
    fzf-tmux -p 80% --reverse --header jump-to-session --preview 'tmux capture-pane -pt {}' --preview-window right:80% |\
    xargs tmux switch-client -t
   }

   vsim_check() {
    if [ $(xrun -version | grep  --only-matching "\s[0-9]*") -eq 21 ]; then 
        echo "XRUN VERSION 21 CONFIRMED"
        vsim $*
   else 
        echo "XRUN VERSION NOT 21 ABORTING"
        echo "bash"
        echo "selectpackage -r CLEAR && export VERILOG_SM=VERILOG--XCELIUM.21.09.007 && selectpackage -p e5ca/REV"
    fi
   }

   toggleshort() {
      export PS1=$short
      # export PS1='\u:\W'
      bindkey '^[[1;5A' togglelong
      zle reset-prompt
   }

   togglelong() {
      export PS1=$long
      bindkey '^[[1;5A' toggleshort
      zle reset-prompt
   }

   cpth() {
      echo -n "${PWD}" | xclip -selection clipboard
      zle reset-prompt

   }

   p() { copypath $* }

   cg(){
      selectlog=($(fd "vsim.log" --maxdepth 5 --type f -I | ag x64 |  fzf-tmux -p 85%,85% --layout=reverse --no-sort --height 15 -e $*))
      if [ -n "$selectlog" ]; then
         ag vsim_cmd $selectlog
      fi
 
   }

   cpcb() {
      xclip -selection clipboard
   }

   simv() {
      simvision &
      disown
   }

   function cl() {
      DIR="$*"
      # if no DIR given, go home
      if [ $# -lt 1 ]; then
         DIR=$HOME
      fi
      builtin cd "${DIR}" &&
         # use your preferred ls command
         ls -1 --color=auto
   }
   goto() {

      cd /runs/simrun_tav/e5ca/REV/TAV/

      selectlog=($(ls -td verilog.e5ca.*$1*/ | fzf-tmux -p 60%,75% -e --prompt "./TAV/" --layout=reverse --no-sort --height 15))
      if [ -n "$selectlog" ]; then
         cd $selectlog
      fi
      zle reset-prompt
   }

   llog() {
      selectlog=($(ls -td log*/ | fzf-tmux --header "log dumps" --no-sort --height 10 --layout=reverse) $*)
      if [ -n "$selectlog" ]; then
         cd $selectlog
      fi
      zle reset-prompt
   }
   getin() {
      selectlog=($(ls -td */ | fzf-tmux -p 85%,85% --layout=reverse --preview 'tree -C -d -L 2 -h --du {} | head -200' --no-sort --height 15 -e $*))  #--preview 'tree -C -d -L 2 -h --du {} | head -200'
      if [ -n "$selectlog" ]; then
         cd $selectlog
      fi
      zle reset-prompt
   }

   nvim(){
    PATH=$PATH:/runs/simrun_tav/libs/bin LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/runs/simrun_tav/libs/lib/ /runs/simrun_tav/libs/bin/nvim $*
   }

   getall() {

   # nvim `fd . -d 5 -t f | fzf-tmux -p 90%,90% --print0 --layout=reverse --no-sort --preview 'bat --color=always --style=numbers --line-range=:500 {}' -e`
    selectlog=($(fzf-tmux -p 85% -e --layout=reverse --no-sort --bind 'shift-up:change-prompt(Depth 1> )+reload(fd . -t f -d 1)' --bind 'shift-down:change-prompt(Depth 5> )+reload(fd . -t f -d 5)' --prompt 'All> ' --header 'CTRL-up: 1-depth / CTRL-down: 5-depth' --preview 'bat --color=always --style=numbers --line-range=:500 {}' --print0))
     if [ -n "$selectlog" ]; then
         nvim $selectlog
      fi
     zle reset-prompt
   }
   getout() {
      cd ..
      zle reset-prompt
   }

   fzfsearch() {

      ls -d */ | fzf -e --print0 --preview 'tree -C -d -L 2 -h --du {} | head -200' --no-sort --color 16 --multi 5 --bind shift-up:preview-up,shift-down:preview-down,shift-right:preview-page-down,shift-left:preview-page-up --height 90%
      zle reset-prompt
   }

   sendMMJ() {
      dird=$(date +%F)
      selectlog=($(ls -t| fzf-tmux -p 80%,70% --layout=reverse --preview 'tree -C -d -L 2 -h --du {} | head -200' --no-sort --height 15 -e) $*)
      mkdir /runs/TO_MMJ/E5CA/REV/soukaling/$dird -v
      cpv $selectlog /runs/TO_MMJ/E5CA/REV/soukaling/$dird
      p /runs/TO_MMJ/E5CA/REV/soukaling/$dird/*
   }

   

   zle -N getin{,}
   zle -N getout{,}
   zle -N getall{,}
   zle -N goto{,}
   zle -N llog{,}
   zle -N fzfsearch{,}
   zle -N togglelong{,}
   zle -N toggleshort{,}
   zle -N cpth{,}
   zle -N session_jumper{,}




   source /home/soukaling/.oh-my-zsh/plugins/vscode/vscode.plugin.zsh
   source /home/soukaling/.oh-my-zsh/plugins/copyfile/copyfile.plugin.zsh
   source /home/soukaling/.oh-my-zsh/plugins/copypath/copypath.plugin.zsh
   source /home/soukaling/.oh-my-zsh/plugins/tmux/tmux.plugin.zsh
   source /home/soukaling/.oh-my-zsh/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
   source /home/soukaling/.oh-my-zsh/plugins/z/z.plugin.zsh
   source /runs/simrun_tav/libs/zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  #source /runs/simrun_tav/libs/zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
   source /runs/simrun_tav/libs/zsh_plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
   plugins=(vscode z tmux copyfile copypath)
  


fi

