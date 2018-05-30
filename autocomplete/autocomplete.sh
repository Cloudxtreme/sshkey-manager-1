#!/bin/bash
mgr_dir="`cd $(dirname $0);pwd`/.."

source $mgr_dir/lib.sh

hint "Copy file to /etc/bash_completion.d/"

exit 1
sudo cp ssh /etc/basg_completion.d/

hint "run the autocompletion"
. /etc/bash_completion.d/ssh
