# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.

source ~/.bashrc


if [ -n "$(echo $ZSH_VERSION)" ]; then
ZSH_THEME="theunraveler" # set by `omz`
   export ZSH="$HOME/.oh-my-zsh"
   source $ZSH/oh-my-zsh.sh
   DISABLE_AUTO_TITLE="true"
   # ENABLE_CORRECTION="true"
   ZSH_DISABLE_COMPFIX="true"
   MODE_INDICATOR="%F{yellow}+%f"
   VI_MODE_SET_CURSOR=true
   
   export BAT_THEME="gruvbox-dark"

   # source ~/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
   source /runs/simrun_tav/libs/zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
   source /runs/simrun_tav/libs/zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
   short=' [%F{247}%1~] %{$fg[red]%}$(git_current_branch)-> '
   long='%(?.%F{green}√.%F{red}?%?)%f %B%m: %F{240}%~ %{$fg_bold[blue]%}$(git_current_branch)
  %% -> '
   export PS1=$short
   export FZF_DEFAULT_COMMAND="fd"
   export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
   export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
   export FZF_DEFAULT_OPTS='--layout=reverse --inline-info --info inline'   

   [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
   HISTFILE=~/.zsh_history
   HISTSIZE=10000
   SAVEHIST=10000
   setopt appendhistory
   bindkey "^[[1~" beginning-of-line
   bindkey "^[[H" beginning-of-line
   bindkey "^[[4~" end-of-line
   bindkey "^[[F" end-of-line
   bindkey "^[[3~" delete-char

   bindkey '^g' goto
   bindkey '^l' llog
   bindkey '^f' fzfsearch

   bindkey '^p' cpth
   
   bindkey '^[[1;5C' getin
   bindkey '^[[1;5D' getout
   bindkey '^[[1;5B' getall
   bindkey '^h' _complete_help

   alias count='find . -type f | wc -l'
   alias x="exit"
   alias e="code -n ~/ ~/.zshrc ~/.aliases ~/.colors ~/.hooks"
   alias r="source ~/.zshrc"
   alias c="clear"
   alias h="history -10"      # last 10 history commands
   alias hc="history -c"      # clear history
   alias hg="history | grep " # +command
   alias cpv='rsync -ah --info=progress2'
   alias lsalias="grep -in --color -e '^alias\s+*' ~/.zshrc | sed 's/alias //' | grep --color -e ':[a-z][a-z0-9]*'"
   alias batgrep=/home/soukaling/bat-extras/bin/batgrep

   toggleshort(){
    export PS1=$short
    bindkey '^[[1;5A' togglelong
    zle reset-prompt  
   }

   togglelong(){
    export PS1=$long
    bindkey '^[[1;5A' toggleshort
    zle reset-prompt  
   }   


   cpth() {
      echo -n "${PWD}" | xclip -selection clipboard
      zle reset-prompt  
      
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

      selectlog=($(ls -td verilog.e5ca.*$1*/ | fzf --no-sort --height 15))
      if [ -n "$selectlog" ]; then
         cd $selectlog
      fi
      zle reset-prompt
   }

   llog() {
      selectlog=($(ls -td log*/ | fzf --no-sort --height 10 --layout=reverse ) $*)
      if [ -n "$selectlog" ]; then
         cd $selectlog
      fi
      zle reset-prompt
   }
   getin() {
      selectlog=($(ls -td */ | fzf --layout=reverse -e --preview 'tree -C -d -L 2 -h --du {} | head -200' --no-sort --color 16 --multi 5 --bind shift-up:preview-up,shift-down:preview-down,shift-right:preview-page-down,shift-left:preview-page-up --height 90% $*))
      if [ -n "$selectlog" ]; then
        cd $selectlog
      fi
      zle reset-prompt
   }

   getall() {
      selectlog=($(ls -t | fzf --layout=reverse -e --no-sort --color 16 --preview 'bat --color=always --style=numbers --line-range=:500 {}' --bind shift-up:preview-up,shift-down:preview-down,shift-right:preview-page-down,shift-left:preview-page-up --height 90% $*))
      if [ -n "$selectlog" ]; then
         $selectlog
      fi
      zle reset-prompt
   }
   getout() {
      cd ..
      zle reset-prompt
   }

   fzfsearch() {

     ls -d */ | fzf -e --preview 'bat --color=always --style=numbers --line-range=:500 {}' --no-sort --color 16 --multi 5 --bind shift-up:preview-up,shift-down:preview-down,shift-right:preview-page-down,shift-left:preview-page-up --height 90%
      zle reset-prompt
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


fi



