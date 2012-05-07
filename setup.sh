#!/bin/bash

for file in \.*; do 
    if [[ -f "${HOME}/${file}" ]]; then
        echo mv "${file}" "${file}.`date +%Y`"
    fi
    echo ln -s "${file}" "${HOME}/${file}"
done

