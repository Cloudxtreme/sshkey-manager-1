# sshkey-manager

# Description
This project help you generate, deploy, store and upload to someplace.
* system : ubuntu 16.04
* architecture : x86
* language : shell

# Preparation
1. openssh (7.3 or up)
  
    We use the option `Include` in openssh configuration and this option is from 7.3p1 or up. 
    
    Check you openssh version:
    ```shell
    $ ssh -V
    ```

    In my system `ubuntu 16.04`, I can not use command `apt update ;apt upgrade` to update my openssh version higher than 7.2(reason is [here](https://serverpilot.io/community/articles/upgrading-openssh-on-ubuntu-lts.html)). If you ssh version is lower than 7.3, we offer a script to help you quick install openssh 7.3p1.
    ```shell
    $ ./update_ssh_7.3.sh
    ```
    
    ps: more information about ssh configuration option, see [here](http://manpages.ubuntu.com/manpages/trusty/man5/ssh_config.5.html)

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

This action generates ssh key and its configuration in `sshkey/<name>/`. There are the ssh private key `<name>`, the ssh public key `<name>.pub` and the ssh configuration `<name>.conf`.
```shell
$ ./sshkey-mgr gen <name>
```
    
For example, I generate a key named `test`:
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
This action will config <name> ssh configuration and sent public key to the server.
```shell
$ ./sshkey-mgr deploy <name>
```

After this action, you can ssh to you server.
```shell
    $ ssh <name>
```
    
For example, I want to deploy the key `test`: 
```shell
$ ./sshkey-mgr deploy test
$ ssh test
```


## restore the configuration
This action will delete the ssh related configuration in `~/.ssh/config.d/`.
```shell
$ ./sshkey-mgr restore <name>
```
    

## list the existing key
```shell
$ ./sshkey-mgr list
```


## upload ssh key
This action will send the key `<name>` to `<direction>` by using scp command.
```shell
$ ./sshkey-mgr upload <name> <direction>
```
    
The `<direction>` format:
```
<direction>
[user]@[domain]:[path]
```

For example:
```shell
$ ./sshkey-mgr upload test xiaoming@192.168.20.1:~/sshkey-storage/
``` 

ps: The propose we design this feature is to offer a interface to share the key with others or just backup you key. You can sent the key to one's machine or a file share system such as Samba.

## update ssh key
This action will copy the contents in `<direction>`.
```shell
$ ./sshkey-mgr update <direction>
```

For example:
```shell
$ ./sshkey-mgr update xiaoming@192.168.20.1:~/sshkey-storage/
``` 
    
