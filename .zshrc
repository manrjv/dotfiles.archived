# my settings:
setopt histignorealldups sharehistory HIST_SAVE_NO_DUPS
setopt correct_all
HISTSIZE=1000
SAVEHIST=2000
HISTFILE=~/.cache/zsh/history
bindkey -v
export KEYTIMEOUT=1
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"

# load bundles using antigen:
source ~/.local/share/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen theme denysdovhan/spaceship-prompt
antigen apply

# bundle settings:
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"
SPACESHIP_PROMPT_ADD_NEWLINE="false"
SPACESHIP_PROMPT_SEPARATE_LINE="false"
SPACESHIP_DIR_TRUNC_REPO="false"
eval spaceship_vi_mode_enable

# keybindings:
bindkey '^ ' autosuggest-accept
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey -M vicmd v edit-command-line

# nvm settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# aliases:
alias vi_on='spaceship_vi_mode_enable'
alias vi_off='spaceship_vi_mode_disable'
alias py38nvim='source $HOME/.venv/py38nvim/bin/activate'
alias wsensors='watch sensors -f'
alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
