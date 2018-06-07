# sshkey-manager

# Description
This project helps you generate, deploy, store and upload ssh key.
* OS : ubuntu 16.04
* Architecture : x86
* Language : shell

# Preparation
1. openssh (7.3 or up)
  
    This project need the version of `openssh` is 7.3p1 or up. 
    
    Check the openssh version:
    ```shell
    $ ssh -V
    ```
    ps: In system `ubuntu 16.04` or lower, openssh cannot update version higher than 7.2 by using `apt` command(reason is [here](https://serverpilot.io/community/articles/upgrading-openssh-on-ubuntu-lts.html)). 
    
    If your ssh version is lower than 7.3, we offer some script to help you quickly install openssh 7.3, 7.4, 7.5.
    ```shell
    $ ./update_ssh_7.3.sh
    $ ./update_ssh_7.4.sh
    $ ./update_ssh_7.5.sh
    ```

    Also, we offer scripts to uninstall those openssh.
    ```shell
    # uninstall 7.3 or 7.5
    $ ./uninstall_openssh.sh

    # uninstall 7.4
    $ ./uninstall_ssh_7.4.sh
    ```
    ps: more information about ssh configuration option, see [here](http://manpages.ubuntu.com/manpages/trusty/man5/ssh_config.5.html)


# Usage 
## admin
* definition:
have the permission to config server, generate ssh key and upload ssh key to remote.
* usage:
```shell
$ ./sshkey-mgr-admin { list | gen <name> | deploy <name> | restore <name> | upload <name> <destination> | update <destination> <name> }
```
## user 
* usage
```shell
$ ./sshkey-mgr-user { list | deploy <name> | restore <name> | update <destination> <name>/all }
```
## parameter
* `<name>` : the name of host. In order to remember and recognize easily, we let the host name the same with key name.
* `<destination>` : the destination of your ssh key storage.
```
format:
[user]@[domain]:[path]
```

# For Admin
## Generate ssh key

```shell
$ ./sshkey-mgr-admin gen <name>
```
This action generates ssh key and its configuration in `sshkey/<name>/`. There are the ssh private key `<name>`, the ssh public key `<name>.pub` and the ssh configuration `<name>.conf`.
    
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


## Deploy the ssh configuration

```shell
$ ./sshkey-mgr-admin deploy <name>
```
This action configs <name> ssh configuration to your host and **sends public key to the server**.

After this action, you can ssh to you server.
```shell
$ ssh <name>
```
    
For example, I want to deploy the key `test`: 
```shell
$ ./sshkey-mgr-admin deploy test
$ ssh test
```


## Restore the configuration
```shell
$ ./sshkey-mgr-admin restore <name>
```
This action deletes the ssh related configuration in `~/.ssh/config.d/` and **the public key in server**.

    

## list the existed keys
```shell
$ ./sshkey-mgr-admin list
```


## upload ssh key from host to remote
This action will send the key `<name>` to `<destination>` by using scp command.
```shell
$ ./sshkey-mgr-admin upload <name> <destination>
```

For example:
```shell
$ ./sshkey-mgr-admin upload test xiaoming@192.168.20.1:~/sshkey-storage/
``` 

ps: The propose we design this feature is to offer an interface to share the key with others or just backup your key(s). You can send the key to one's machine or a file share system such as Samba.

## update host ssh key from remote
This action will copy the contents in `<destination>`.
```shell
$ ./sshkey-mgr-admin update <destination>
```

For example:
```shell
$ ./sshkey-mgr-admin update xiaoming@192.168.20.1:~/sshkey-storage/
``` 

# For user

## update host ssh key from remote
This action will copy the contents in `<destination>`.
```shell
$ ./sshkey-mgr-user update <destination> <name>/all
```

For example:

* I want the ssh key named `test` in `xiaoming@192.168.20.1:~/sshkey-storage/`
```shell
$ ./sshkey-mgr-user update xiaoming@192.168.20.1:~/sshkey-storage/ test
```
* I want all the ssh key in `xiaoming@192.168.20.1:~/sshkey-storage/` 
```shell
$ ./sshkey-mgr-user update xiaoming@192.168.20.1:~/sshkey-storage/ all
```

## Deploy the ssh configuration

```shell
$ ./sshkey-mgr-user deploy <name>
```
This action configs <name> ssh configuration to your host.

After this action, you can ssh to you server.
```shell
$ ssh <name>
```
    
For example, I want to deploy the key `test`: 
```shell
$ ./sshkey-mgr-user deploy test
$ ssh test
```


## Restore the configuration
```shell
$ ./sshkey-mgr-user restore <name>
```
This action deletes the ssh related configuration in `~/.ssh/config.d/`.

    
## list the existed keys
```shell
$ ./sshkey-mgr-user list
```


# Advanced
1. autocomplete

    According to my research, openssh seems not support autocomplete of your Host name in ssh configuration.So we offer a script to config the autocomplete.
    ```shell
    $ cd autocomplete/
    $ ./autocomplete.sh
    ```

    This need the sudo permission to copy file `ssh` to `/etc/bash_completion.d/`.
    After running the script, you need to open another terminal to check it work.

    ps: more information of autocomplete configuration, see [here](https://debian-administration.org/article/317/An_introduction_to_bash_completion_part_2)
