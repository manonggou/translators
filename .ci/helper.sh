#!/bin/bash

if [[ -t 1 && "$(tput colors)" -gt 0 ]]; then
    export color_ok=$'\e[32;1m'
    export color_notok=$'\e[31;1m'
    export color_warn=$'\e[33m'
    export color_err=$'\e[31m'
    export color_reset=$'\e[0m'
fi

get_translator_id() {
    if [[ -n "$1" ]];then
        grep -r '"translatorID"' "$@" | sed -e 's/[" ,]//g' -e 's/^.*://g'
    else
        while read line;do
            echo "$line"|grep '"translatorID"' | sed -e 's/[" ,]//g' -e 's/^.*://g'
        done
    fi
}

get_translators_to_check() {
	
	TRANSLATORS_TO_CHECK=$(git diff $(git rev-list "$(git rev-list --first-parent ^origin/master HEAD | tail -n1)^^!") --name-only | grep -e "^[^/]*.js$")
}
