#!/usr/bin/env bash

alias vimrc="${EDITOR} ~/.vimrc"

fuck() {
    if [ $1 = "--help" ] || [ $1 = "-h" ]; then
        echo "usage: fuck"
        echo "  Repeats the last command using sudo."
        echo ""
    elif [ $1 = "--version"] || [ $1 = "-v" ]; then
        echo "1.0.0"
    else
        sudo $(history -p \!\!)
    fi
}

weather() {
    local city
    city=Amsterdam

    if [ $# -gt 0 ]; then
        if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
            echo "usage: $0 <city>"
            echo "  Displays the weather report for the given city. Amsterdam by default."
            echo ""
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

if [[ $(uname) == 'Darwin' ]] && fzf --version >/dev/null 2>&1 ; then
    app() {
        find /Applications ~/Applications -iname "*.app" -maxdepth 3 | fzf | sed 's/ /\\ /g' | xargs open 
    }
fi
