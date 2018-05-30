#!/bin/bash

function Parameter_judge() {
    correct_num="$1"
    real_num="$2"
    if [ $correct_num != $real_num ];then
        Usage
    fi
}

function hint() {
    GREEN='\033[0;32m'
    NC='\033[0m' # No Color
    printf "${GREEN}=================================${NC}\n"
    printf "${GREEN}$1${NC}\n"
    printf "${GREEN}=================================${NC}\n"
}
