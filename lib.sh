#!/bin/bash
mgr_dir=`cd $(dirname $0);pwd`
key_dir="$mgr_dir/sshkey"

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

function List() {
    cd $key_dir/
    number=`ls -d */ | wc -l`
    echo "Total:" $number
    for key in `ls -d */`
    do
        tree $key
    done
}

function Fetch() {
    direction="$1"
    name="$2"

    if [ "$name" == "all" ];then
        scp -r $direction/* $key_dir
        exit 1
    fi

    host="$(cut -d':' -f1 <<< $direction)"
    path="$(cut -d':' -f2 <<< $direction)"
    
    scp -r $direction/$name $key_dir
}