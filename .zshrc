#        __________   ____________                                      
#       |  ________| |____    ____|                                     
#       |  |  __________  |  |                                          
#       |  | |   _______| |  |  File:        .zshrc                     
#       |  | |  |_______  |  |  Desc:         Personal zsh configuration
#       |  | |_______   | |  |                                          
#       |  |  _______|  | |  |  Maintainer:  <Justin Saluja>            
#       |  | |__________| |  |  Email:       <salujajustin@gmail.com>   
#   ____|  |____   _______|  |  Github:      <salujajustin>             
#  |____________| |__________|                                          

# Store system kernel as a variable 
system_type=$(uname -s)

# Path to your oh-my-zsh installation.
if [ "$system_type" = "Darwin" ]; then
    export ZSH="/Users/justinjohnsonsaluja/.oh-my-zsh" 
else
    export ZSH="/home/justin/.oh-my-zsh"
fi

# Set name of the theme to load 
ZSH_THEME="common"

# CASE_SENSITIVE="true"           # case sensitive completion
# HYPHEN_INSENSITIVE="true"       # _ and - will be interchangeable, req. CASE_SENSITIVE=false
# DISABLE_AUTO_UPDATE="true"      # disable bi-weekly auto-update checks.
# DISABLE_UPDATE_PROMPT="true"    # automatically update without prompting.
# export UPDATE_ZSH_DAYS=13       # change how often to auto-update (in days).
# DISABLE_MAGIC_FUNCTIONS=true    # uncomment if pasting URLs and other text is messed up.
# DISABLE_AUTO_TITLE="true"       # disable auto-setting terminal title.
# ENABLE_CORRECTION="true"        # enable command auto-correction.
# COMPLETION_WAITING_DOTS="true"  # display red dots whilst waiting for completion.

# Which plugins would you like to load?
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR='vim'

# For a full list of active aliases, run `alias`.
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"

# Kitty configuration
autoload -Uz compinit
compinit
kitty + complete setup zsh | source /dev/stdin  # Completion for kitty
alias kittyconf="vim ~/.config/kitty/kitty.conf"
alias icat="kitty +kitten icat"
alias d="kitty +kitten diff"

# Import colorscheme from 'wal' asynchronously
(cat ~/.cache/wal/sequences &)
