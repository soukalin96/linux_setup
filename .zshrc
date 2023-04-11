# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.

source ~/.bashrc

if [ -n "$(echo $ZSH_VERSION)" ]; then
ZSH_THEME="mira" # set by `omz`
   export ZSH="$HOME/.oh-my-zsh"
   export PATH="$HOME/local/bin:$HOME/local/bin/usr/local/bin:$PATH"
   export PATH="$HOME/bin:$PATH"
   export PATH="/home/soukaling/.cargo/bin/:$PATH"
   export CPATH="/home/soukaling/include:$CPATH"
   export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/home/soukaling/lib/pkgconfig"
   export XDG_CONFIG_HOME="/home/soukaling/.config"
   export PATH="/runs/simrun_tav/tav_dev/users/soukaling/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$PATH"

   fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

   source $ZSH/oh-my-zsh.sh
   DISABLE_AUTO_TITLE="true"
   # ENABLE_CORRECTION="true"
   ZSH_DISABLE_COMPFIX="true"
   MODE_INDICATOR="%F{yellow}+%f"
   VI_MODE_SET_CURSOR=true
   
   plugins=(vscode zsh-interactive-cd)
   export BAT_THEME="gruvbox-dark"

   short='%{$fg[red]%}[$(basename $(pwd))] %{$fg_bold[blue]%}$(git_current_branch)%{$fg_bold[green]%} $(/home/soukaling/term_nvim_setup/xrunv.sh)%f%b -> '
   long='%(?.%F{green}√.%F{red}?%?)%f %B%m: %F{240}%~ %{$fg_bold[blue]%}$(git_current_branch)%{$fg_bold[green]%} $(/home/soukaling/term_nvim_setup/xrunv.sh)
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
   # bindkey '\e[1;5C' getin
   # bindkey '\e[1;5D' getout
   bindkey '\e[1;5C' forward-word
   bindkey '\e[1;5D' backward-word
   bindkey '\e[1;5B' getall
   bindkey '\e[1;5A' gotop
   bindkey '^h' _complete_help
   bindkey "^[[1;3C" getin 
   bindkey "^[[1;3D" getout
   # bindkey "^[[1;3C" forward-word 
   # bindkey "^[[1;3D" backward-word

   alias act="alacritty --config-file ~/alacritty.yml & disown"
   alias count='fd . -t f | wc -l'
   alias x="exit"
   alias e="nvim ~/.zshrc"
   alias r="source ~/.zshrc"
   alias c="clear"
   alias p='copypath'
   alias h="history -10"      # last 10 history commands
   alias hc="history -c"      # clear history
   alias hg="history | grep " # +command
   alias cpv='rsync -ah --info=progress2'
   alias bg=/home/soukaling/bat-extras/bin/batgrep
   alias bd=/home/soukaling/bat-extras/bin/batdiff
   # alias tmux=/home/soukaling/local/bin/tmux
   alias LS='tmux resize-pane -x 30; while sleep 1; do clear && tree -Ctdh -L 2 "$(tmux display-message -p -F "#{pane_current_path}" -t1)"; done'
   alias hubapp=/home/soukaling/local/bin/hubapp
   alias lst="lsd -ltrah"
   alias ll="lsd -lah"
   alias l="lsd -lah"
   alias ls="lsd"
   alias bh="bt -ih"
   alias bl="bt -sdp"
   alias cmake="/home/soukaling/local/bin/usr/local/bin/cmake"
   alias xcp="xcp --no-perms"
   alias wavefd='fd waves --type d --maxdepth 7 -I -t --owner soukaling'
   alias rmrf='rm -rf'
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

   toggleshort() {
      export PS1=$short
      zle reset-prompt
   }

   togglelong() {
      export PS1=$long
      zle reset-prompt
   }

   cpth() {
      # echo -n "${PWD}" | xclip -selection clipboard
      # echo copied ${PWD}
      copypath
      zle send-break
   }

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

   tre() { command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null; }
   
   gotop() {
      pathtb=($(echo ${PWD} | cut -d "/" -f -7))
      patchcheck=($(echo ${PWD} | cut -d "/" -f 7-7 | cut -d "." -f 1)) 
      if [ "$patchcheck" = "verilog" ]; then
         cd $pathtb
      fi
      zle reset-prompt
   }

   goto() {
      cd /runs/simrun_tav/e5ca/REV/TAV/
      selectlog=($(ls -td verilog.e5ca.*$1*/ | fzf-tmux -p 60%,75% --color 16 -e --prompt "./TAV/" --layout=reverse --no-sort --height 15))
      if [ -n "$selectlog" ]; then
         cd $selectlog
      fi
      zle reset-prompt
   }

   llog() {
      selectlog=($(fd log -td --prune -I -E HBM3 | fzf-tmux --header "log dumps" --color 16 --no-sort --height 10 --layout=reverse) $*)
      if [ -n "$selectlog" ]; then
         cd $selectlog
      fi
      zle reset-prompt
   }
   getin() {
      selectlog=($(ls -td */ | fzf-tmux -p 85%,85% --color 16 --layout=reverse --preview 'tree -C -d -L 2 -h --du --filelimit 50 {} | head -200' --no-sort --height 25 -e $*))  #--preview 'tree -C -d -L 2 -h --du {} | head -200'
      if [ -n "$selectlog" ]; then
         cd $selectlog
         getin
      fi
      zle reset-prompt
   }

   nvim(){
      PATH=$PATH:/runs/simrun_tav/libs/bin LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/runs/simrun_tav/libs/lib/ /runs/simrun_tav/libs/bin/nvim $*
   }

   getall() {

   selectlog=($(fd . -d 1 -t f | fzf-tmux -p 85% -e --color 16 --layout=reverse --no-sort --bind 'shift-up:change-prompt(Depth 1> )+reload(fd . -t f -d 1)' --bind 'shift-down:change-prompt(Depth 5> )+reload(fd . -t f -d 5)' --prompt 'All> ' --header 'CTRL-up: 1-depth / CTRL-down: 5-depth' --preview 'bat --color=always --style=numbers --line-range=:500 {}' --print0))
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
      dird=$(date +%d_%m_%Y)
      selectlog=($(ls -t| fzf-tmux -p 80%,70% --layout=reverse --preview 'tree -C -d -L 2 -h --du {} | head -200' --no-sort --height 15 -e) $*)
      mkdir /runs/TO_MMJ/E5CA/REV/soukaling/$dird -v
      xcp --no-perms -r $selectlog /runs/TO_MMJ/E5CA/REV/soukaling/$dird 
      p /runs/TO_MMJ/E5CA/REV/soukaling/$dird/*
   }

   bt() {
      local cmd cmd_file code
      cmd_file=$(mktemp)
      if broot --outcmd "$cmd_file" "$@"; then
         cmd=$(<"$cmd_file")
         command rm -f "$cmd_file"
         eval "$cmd"
      else
         code=$?
         command rm -f "$cmd_file"
         return "$code"
      fi
   }


   zle -N getin{,}
   zle -N getout{,}
   zle -N getall{,}
   zle -N goto{,}
   zle -N gotop{,}
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
   source /runs/simrun_tav/libs/zsh_plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
   plugins=(vscode z tmux copyfile copypath)

   export STARSHIP_CONFIG=~/term_nvim_setup/starship.toml
   eval "$(starship init zsh)"

fi
