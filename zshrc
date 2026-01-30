# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git 
  z 
  zsh-syntax-highlighting 
  history-substring-search
  )

source $ZSH/oh-my-zsh.sh
alias g='gnuplot'
alias pt='p test.py'
alias vt='vim test.py'
alias ls='ls --color=auto -hF'
alias ll='ls -lah'
alias la='ls -A'
alias vm='vim main.tex'
alias vn='vim /Users/shman/Desktop/postdoc/notepad.md' 
alias vvrc='vim /Users/shman/.vimrc' 
alias vzrc='vim /Users/shman/.zshrc' 
alias vtrc='vim /Users/shman/.vim/ftplugin/tex.vim'  
# alias ls='ls -G'
alias refresh='source ~/.zshrc'
alias p='uv run'
alias vr='vim README.md'
alias cdr='cd ~/Desktop/postdoc'
alias osc='cd ~/Desktop/postdoc/oscillators'
alias cic='cd ~/Desktop/postdoc/cic' 
alias texosc='cd ~/Desktop/postdoc/oscillators_tex'
alias texcic='cd ~/Desktop/postdoc/cic_tex' 
alias mrun='make ./main > res.dat'
alias pactivate='source ~/.venv/bin/activate'
alias dtu='ssh shman@login1.gbar.dtu.dk'
alias rr='open -a "Marked 2" README.md'

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS     # Don’t record duplicate commands
setopt HIST_FIND_NO_DUPS  

export EDITOR='vim'

function dtusend() {
  ~/.bashscripts/dtuSCPSend.sh -s $1 -t $2 
}

function dtuget() {
  ~/.bashscripts/dtuSCPReceive.sh -s $1 -t $2 
}

function oscget() {
  ~/.bashscripts/dtuSCPReceive.sh -s oscillators/$1 -t $2 
}

function cicget() {
  ~/.bashscripts/dtuSCPReceive.sh -s cic/$1 -t $2 
}

function supersplit() {
  ~/.bashscripts/superSplit.sh -i $1 -n $2 -o $3 
}

function supersplitdir() {
  for j in $(seq 1 $1);
  do
    if ((j < 10)); then
      ~/.bashscripts/superSplit.sh -i exp_0${j}/res.dat -n $2 -o exp_0${j}/split 
    else
      ~/.bashscripts/superSplit.sh -i exp_${j}/res.dat -n $2 -o exp_${j}/split 
    fi
  done
}

function splitany() {
  ~/.bashscripts/split_any.sh "$@"
}

function splitmany() {
  ~/.bashscripts/split_many.sh "$@"
}

function splithere() {
  ~/.bashscripts/split_any_here.sh "$@"
}

function splitlast() {
  ~/.bashscripts/splitLast.sh -i $1 -n $2 -o $3 
}

function tikzdata() {
  pactivate
  ~/.bashscripts/tikzFromFile.sh -i $1 -o $2 -s $3
}

function tikzupload() {
  pactivate
  ~/.bashscripts/tikzFromMany.sh -i $1 -n $2

}

function mkexpdir() {
  ~/.bashscripts/makeExpDir.sh
}

function fetchresults() {
  ~/.bashscripts/dtu_SCP_mirroring_directory.sh
}

function tidynames() {
  for j in $(seq 1 9);
  do
    mv exp_${j} exp_0${j}
  done
}

function cdp() {
  builtin cd $1 || return
  if [[ "$PWD" == "/Users/shman/Desktop/postdoc/cic_tex" ]]; then
    echo "Entered project directory — syncing data..."
    ~/.bashscripts/updateCicData.sh
  fi

}

function cdt() {
  local p=${PWD}
  # Find the portion of the path starting after "postdoc/"
  local after=${p#*/postdoc/}

  # If unchanged, "postdoc" wasn't found
  if [[ "$after" == "$p" ]]; then
    echo "No 'postdoc' directory found in path."
    return 1
  fi

  # Extract the directory directly under postdoc (the project directory)
  local project=${after%%/*}

  # Navigate there
  cd "~/Desktop/postdoc/$project"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
