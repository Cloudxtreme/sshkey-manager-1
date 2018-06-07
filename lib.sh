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

function Deploy_Client() {
    name="$1"
    ip=`cat $key_dir/$name/$name.conf | grep Hostname | awk -F " " '{print $2}'`

    # create ~/.ssh/config if there is no such file
    if [ ! -f "$HOME/.ssh/config" ];then
        hint "check ~/.ssh/config exists"
        touch $HOME/.ssh/config
    fi

    # check whether ~/.ssh/config have content
    if [ -z "$(cat $HOME/.ssh/config)" ];then
        echo > $HOME/.ssh/config
    fi

    # create ~/.ssh/config.d if there is no such directory
    if [ ! -d "$HOME/.ssh/config.d" ];then
        hint "create directory : ~/.ssh/config.d"
        mkdir $HOME/.ssh/config.d
    fi

    # add "Include config.d/*"to ~/.ssh/config if there is no such line
    if [ -z "$(cat $HOME/.ssh/config | grep 'Include config.d/*')" ];then 
        sed -i '1 i\Include config.d/*' $HOME/.ssh/config
    fi

    # authority
    hint "authority whether host exists"
    cat ~/.ssh/config | grep "Host $name" && \
    echo "The machine ( $name ) is already exist in ~/.ssh/config " && \
    exit 1

    ls ~/.ssh/config.d | grep $name.conf && \
    echo "The machine ( $name ) configuration is already exist in ~/.ssh/config.d/" && \
    exit 1

    echo "No machine named $name"

    # add config to ~/.ssh/config.d
    hint "Copy configuration to ~/.ssh/config.d"
    cp $key_dir/$name/$name.conf $HOME/.ssh/config.d/
    sed -i "s+PATH+$key_dir/$name/$name+g" $HOME/.ssh/config.d/$name.conf

    cat $HOME/.ssh/config.d/$name.conf
}

function Restore_Client() {
    name="$1"

    hint "Remove $name.conf in ~/.ssh/config.d/"
    rm $HOME/.ssh/config.d/$name.conf
}
