#export PATH=$HOME/loqq:$PATH
#set +h
#export MANPATH=$HOME/man/:$MANPATH
export PATH=$PATH:$HOME/bin

#export CPATH=$HOME/work/mycode/c/apue.2e/include/:$CPATH
export EDITOR='vim'
export VISUAL='vim'
#export PS1="[\t \w]\\$ "
export PS1="\[\e]0;\u@\h: \w\a\]\[\e[1;31m\]\u\[\e[1;32m\]@\h\[\033[0m\]: \[\e[1;34m\]\w\[\033[0m\] \[\e[1;35m\]\$ \[\033[0m\]"
#export PYTHONSTARTUP="$HOME/.pythonstartup.py"

alias grep="grep --color"
alias cls="clear"
#alias cp="cp -i"
alias cd2="cd ../.."
alias cd3="cd ../../.."
alias cd4="cd ../../../.."

alias cs="cscope -Rbq"
alias css="cscope -bq *.c *.h"


if [ -d $HOME/work ] ; then
	alias zz="cd $HOME/work"
fi

#use google
google() {
	search=""
	for term in $*; do
		search="$search%20$term"
	done
	w3m "http://www.google.com.hk/search?q=$search"
}

#export P4CONFIG=$HOME/.p4config
#export P4ROOT=$HOME/p4root_ryli_ubuntu1104

#export BOOST_PATH=${QUADD_EXTERNALS}/boost_1_50_0


