#!/bin/bash

function Parameter_judge() {
    correct_num="$1"
    real_num="$2"
    if [ $correct_num != $real_num ];then
        Usage
    fi
}


