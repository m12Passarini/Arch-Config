#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export VIRTUAL_ENV_DISABLE_PROMPT=0

alias ls='ls --color=auto'
alias grep='grep --color=auto'

if [ -f /usr/share/git/completion/git-prompt.sh ]; then
    source /usr/share/git/completion/git-prompt.sh
elif [ -f /etc/bash_completion.d/git-prompt ]; then
    source /etc/bash_completion.d/git-prompt
fi

GIT_PS1_SHOWDIRTYSTATE=1    
GIT_PS1_SHOWSTASHSTATE=1   
GIT_PS1_SHOWUNTRACKEDFILES=1 
GIT_PS1_SHOWUPSTREAM="auto" 

get_venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
	    echo -e " $(basename "$VIRTUAL_ENV") (venv)" 
    fi
}

format_path() {
    local path="${PWD}"
    if [[ "$path" == "$HOME" ]]; then
        echo -n "~/"
    elif [[ "$path" == "/" ]]; then
 	echo -n "/root"
    else
        echo -n "${path/#$HOME/~}/"
    fi          
}

ARCH_ICON="\[\e[37;5;75m\]" 

PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'
PS1='\[\e[38;5;75m\] '
PS1+='\[\e[38;5;214m\]$(get_venv) '  
PS1+='\[\e[38;5;228m\]$(format_path)\a'  
PS1+='\[\e[38;5;203m\]${PS1_CMD1}'  
PS1+='\n\[\e[38;5;86m\]\$\[\e[0m\]  '

eval "$(pyenv init --path)"
eval "$(pyenv init -)"

rm() {
    echo ""	
    echo " Command 'rm' remove files permanently!"
    echo " Instead this, try use 'trash-cli':"
    echo ""
    echo "    trash-put file_name"
    echo ""
    read -p "Do you want use 'rm'? (Y/N) " answer

    if [[ "$answer" =~ ^[sS]$ ]]; then
        /bin/rm "$@"
    else
        echo "Operação cancelada."
    fi
}
