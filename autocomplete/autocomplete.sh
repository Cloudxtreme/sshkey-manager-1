#!/bin/bash
mgr_dir="`cd $(dirname $0);pwd`/.."

source $mgr_dir/lib.sh

hint "Copy file to /etc/bash_completion.d/"
sudo cp ssh /etc/bash_completion.d/

hint "run the autocompletion"
cd /etc/bash_completion.d/
. /etc/bash_completion.d/ssh
