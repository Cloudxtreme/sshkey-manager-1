# sshkey-manager

# Description
This project help you generate, deploy, store and upload to someplace.
* system : ubuntu 16.04
* architecture : x86
* language : shell

# Preparation
1. openssh (7.3 or up)
  
    We use the option `Include` which is from 7.3p1 or up. 
    
    Check you openssh version:
    ```shell
    $ ssh -V
    ```
    In my system `ubuntu 16.04`, I can not use command `apt update ;apt upgrade` to update my openssh version. If you ssh version is lower than 7.3, we offer a script to help you quick install openssh 7.3.
    ```shell
    $ ./update_ssh_7.3.sh
    ```
    ps: more information of ssh configuration option, see [here](http://manpages.ubuntu.com/manpages/trusty/man5/ssh_config.5.html)

2. autocomplete

    According to my research and use, openssh won't support autocomplete of configuration that specified by option `Include`.So we offer a script to config the autocomplete.
    ```shell
    $ cd autocomplete/
    $ ./autocomplete.sh
    ```
    This need the sudo permission to copy file `ssh` to `/etc/bash_completion.d/`.
    ps: more information of autocomplete configuration, see [here](https://debian-administration.org/article/317/An_introduction_to_bash_completion_part_2)

# How to use
## generate ssh key

    ```shell
    $ ./sshkey-mgr gen <name>
    ```
    This need you offer `user` and `ip`, and this will generate three files in `sshkey/<name>`. There are the ssh private key `<name>`, the ssh public key `<name>.pub` and the ssh configuration `<name>.conf`.
    
    For example, i generate a key named `test`:
    ```shell
    # generate key
    $ ./sshkey-mgr gen <name>

    # list the key
    $ ./sshkey-mgr list
    test/
    ├── test
    ├── test.conf
    └── test.pub

    0 directories, 3 files
    ```

## deploy the ssh configuration to you host
    ```shell
    $ ./sshkey-mgr deploy <name>
    ```
    This action will config <name> ssh configuration and sent public to the server.
    After this action, you can ssh to you server that you just specified.
    ```shell
    $ ssh <name>
    ```
    For example:
    ```shell
    $ ./sshkey-mgr deploy test
    $ ssh test
    ```

## restore the configuration
    ```shell
    $ ./sshkey-mgr restore <name>
    ```
    This action will delete the ssh related configuration.

## list the existing key
    ```shell
    $ ./sshkey-mgr list
    ```

## upload ssh key
    ```shell
    $ ./sshkey-mgr upload <name> <direction>
    ```
    This action will send the key <name> to <direction> by using scp command.
    The <direction> format:
    ```
    <direction>
    [user]@[domain]:[path]
    ```
    For example:
    ```shell
    $ ./sshkey-mgr upload test xiaoming@192.168.20.1:~/sshkey-storage/
    ``` 
    ps: The propose we design this feature is to offer a interface to share the key with others. You can sent the key to one's machine or a file share system such as Samba.

## update ssh key
    ```shell
    $ ./sshkey-mgr update <direction>
    ```
    This action will copy the contents in <direction>.
