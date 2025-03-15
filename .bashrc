#
# ~/.bashrc
#

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"

rm() {
    echo ""	
    echo " The command 'rm' remove the items permanently!"
    echo " Instead that, try use 'trash-cli':"
    echo ""
    echo "    trash-put file_name"
    echo ""
    read -p "Are you sure to use 'rm'? (S/N) " answer

    if [[ "$answer" =~ ^[sS]$ ]]; then
        /bin/rm "$@"
    else
        echo "Canceled operation"
    fi
}
