#!/usr/bin/env bash

# from https://github.com/triketora/dotfiles/blob/master/bash_profile
SSH_ENV="${HOME}/.ssh/environment"
function start_ssh_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo "Success!"
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_ssh_agent;
     }
else
     start_ssh_agent;
fi


alias vimrc="${EDITOR} ${HOME}/.vimrc"

if command -v ccat >/dev/null 2>&1; then 
    alias cat=ccat
fi

fuck() {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "usage: $0"
        echo "  Repeats the last command using sudo."
    elif [ "$1" = "--version" ] || [ "$1" = "-v" ]; then
        echo "1.0.0"
    else
        sudo $(fc -ln 0 | tail -n1)
    fi
}

weather() {
    local city
    city=Amsterdam

    if [ $# -gt 0 ]; then
        if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
            echo "usage: $0 <city>"
            echo "  Displays the weather report for the given city. Amsterdam by default."
            return 0
        elif [ "$1" = "--version" ] || [ "$1" = "-v" ]; then
            echo "1.0.0"
            return 0
        else
            city=$1
        fi
    fi

    if http --version >/dev/null 2>&1; then
        http -b GET "http://wttr.in/$city"
    else
        curl -X GET "http://wttr.in/$city"
    fi
}

base64() {
    command -v openssl >/dev/null 2>&1 || { 
        echo "Required openssl but it's not installed.  Aborting." >&2
        exit 1
    }

    if [ $# -eq 2 ]; then
        if [ "$1" =  "-e" ]; then
            echo "$2" | openssl base64 -e
            return 0
        elif [ "$1" = "-d" ]; then
            echo "$2" | openssl base64 -d -A
            return 0
        fi   

    elif [ "$1" = "--version" ] || [ "$1" = "-v" ]; then
        echo "1.0.0"
        return 0
    
    elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "usage: $0 [-ed] <string>"
        echo "  Encodes/Decodes the given string into base64."
        echo "  Options: "
        echo ""
        echo "    -e Encodes the given string into base64."
        echo "    -d Decodes the given base64 string."
        return 0
    else
        echo "Invalid usage. Type $0 --help for more information."
        return 1
    fi
}

crypt() {
    command -v openssl >/dev/null 2>&1 || { 
        echo "Required openssl but it's not installed.  Aborting." >&2
        exit 1
    }

    if [ $# -eq 3 ]; then
        if [ "$1" =  "-e" ]; then
            openssl enc -e -aes256 -in $2 -out $3
            return 0
        elif [ "$1" = "-d" ]; then
            openssl enc -d -aes256 -in $2 -out $3
            return 0
        fi   

    elif [ "$1" = "--version" ] || [ "$1" = "-v" ]; then
        echo "1.0.0"
        return 0
    
    elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "usage: $0 [-ed] <input> <output>"
        echo "  Encodes/Decodes the given file."
        echo "  Options: "
        echo ""
        echo "    -e Encodes the given file in <input> in <output>."
        echo "    -d Decodes the given file in <input> in <output>."
        return 0;
    else
        echo "Invalid usage. Type $0 --help for more information."
        return 1
    fi
}

# OS X specifics
if [[ $(uname) == 'Darwin' ]] && fzf --version >/dev/null 2>&1 ; then
    app() {
        if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
            echo "usage: $0 <name>"
            echo "  Searchs and opens an application with name <name> or all of the available if empty."
            echo "  The search is done in /Applications and $HOME/Applications."
            return 0
        elif [ "$1" = "--version" ] || [ "$1" = "-v" ]; then
            echo "1.0.0"
            return 0
        else
            find /Applications ${HOME}/Applications -iname "*$1*.app" -maxdepth 3 | fzf | sed 's/ /\\ /g' | xargs open
        fi
    }
fi
