# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

fpath=($HOME/.zsh/custom_completions $fpath)
# Set up the prompt

#ZSH_THEME=agnoster

plugins=( 
# other plugins...
zsh-autosuggestions
)

# make less maintain colors
export LESS='-R'


export DOTFILES_REPOSITORY_PATH="$HOME/dotfiles"

source "$HOME/.zsh/prompt.zsh"

setopt histignorealldups sharehistory

bindkey -v 
bindkey '^R' history-incremental-search-backward

source "$HOME/.zsh/globals.zsh"
source "$HOME/.zsh/exports.zsh"
source "$HOME/.zsh/completions.zsh"
source "$HOME/.zsh/os.zsh"


#source ~/antigen.zsh
#antigen bundle b4b4r07/zsh-vimode-visual
source "$HOME/.zsh/aliases.zsh"

# Added for mf, remove if you are someone else
source "$HOME/.zsh/aliases_mf.zsh"

source "$HOME/.zsh/functions.zsh"

# Added for mf, remove if you are someone else
source "$HOME/.zsh/functions_mf.zsh"

#small_fortune

#Ignore certain file extensions when autocompleting
# For all programs
#fignore=(log)
#fignore+=(aux)

# Here, with neovim, ignore .(aux|log|pdf) files
zstyle ':completion:*:*:nvim:*' file-patterns '^*.(aux|log|pdf|bcf|bbl|blg|bib|out|xml|toc):source-files' '*:all-files'


function preexec() {
    python3 "$DOTFILES_REPOSITORY_PATH/has_alias/has_alias.py" "$1"
}

export XDG_CONFIG_HOME="$HOME/.config/"

# export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
fpath=($HOME/.zsh/custom_completions $fpath)

export TF_CPP_MIN_LOG_LEVEL=2
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
