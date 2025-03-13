#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"

rm() {
    echo ""	
    echo " O comando 'rm' exclui arquivos permanentemente!"
    echo " Em vez disso, tente usar o 'trash-cli':"
    echo ""
    echo "    trash-put nome_do_arquivo"
    echo ""
    read -p "Tem certeza que quer usar 'rm'? (S/N) " answer

    if [[ "$answer" =~ ^[sS]$ ]]; then
        /bin/rm "$@"
    else
        echo "Operação cancelada."
    fi
}
