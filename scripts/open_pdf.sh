#!/bin/zsh

if [[ "$(uname)" == "Darwin" ]]; then
    open ~/archivo/notas/librero/"${1:1}".pdf
elif [[ "$(uname)" == "Linux" ]]; then
    xdg-open ~/archivo/notas/librero/"${1:1}".pdf
else
    echo "OS no compatible"
    exit 1
fi

