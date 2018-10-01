# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias ls='ls -lh --color=auto'
#alias gitpp='git pull && git push'
alias gitpp='git fetch && git rebase -i origin/master && git push origin +HEAD'
alias htop='TERM=screen htop'
alias bzip2='pbzip2'
alias bunzip2='pbunzip2'
which nvim &> /dev/null && alias vim='nvim'

function _git_prompt() {
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local ansi=42
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local ansi=43
        else
            local ansi=41
        fi
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
            test "$branch" != master || branch=' '
        else
            # Detached HEAD.  (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
                echo HEAD`)"
        fi
        echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
    fi
}

function _prompt_command() {
    PS1="`_git_prompt`"'[\u \t \[\033[0;34m\]\w\[\033[0;30m\]]\$\[\e[0m\] '
}

PROMPT_COMMAND=_prompt_command
