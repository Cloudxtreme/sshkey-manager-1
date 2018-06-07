# sshkey-manager

# Description
This project helps you generate, deploy, store and upload ssh key.
* OS : Ubuntu 16.04
* Architecture : x86
* Language : shell

# Preparation
1. openssh (7.3 or up)
  
    This project requires the version of `openssh` 7.3p1 or up. 
    
    Check the `openssh` version:
    ```shell
    $ ssh -V
    ```
    >In system `ubuntu 16.04` or lower, openssh cannot update version higher than 7.2 by using `apt` command ( reason is [here](https://serverpilot.io/community/articles/upgrading-openssh-on-ubuntu-lts.html) ). 
    
    If your ssh version is lower than 7.3, we offer some scripts to help you install openssh 7.3, 7.4, 7.5 quickly.
    ```shell
    $ ./update_ssh_7.3.sh
    $ ./update_ssh_7.4.sh
    $ ./update_ssh_7.5.sh
    ```

    Also, we provide scripts to uninstall those openssh.
    ```shell
    # uninstall 7.3 or 7.5
    $ ./uninstall_openssh.sh

    # uninstall 7.4
    $ ./uninstall_ssh_7.4.sh
    ```
    >For more information about ssh configuration option, see [here](http://manpages.ubuntu.com/manpages/trusty/man5/ssh_config.5.html)


# Usage 
## admin
* definition:
The admin has the permission to config server, generate ssh key and upload ssh key to remote.
* usage:
    ```shell
    $ ./sshkey-mgr-admin { list | gen <name> | deploy-c <name> | deploy-s <name> | restore-c <name> | restore-s <name> | upload <name> <storage> | fetch <storage> <name>/all }
    ```

## user 
* usage
    ```shell
    $ ./sshkey-mgr-user { list | deploy-c <name> | restore-c <name> | fetch <storage> <name>/all }
    ```

## parameter
* `<name>` : the name of the server. In order to remember and recognize easily, we make the server name the same as key name.

* `<storage>` : the storage of your ssh key.
    ```
    format:
    [user]@[domain]:[path]
    ```

# For Admin
## Generate ssh key

```shell
$ ./sshkey-mgr-admin gen <name>
```
This action generates ssh key and its configuration in `sshkey/<name>/`. The structure is like below:
```
sshkey/<name>/
├── <name>
├── <name>.conf
└── <name>.pub
```
    
For example, you want to generate a key named `test`:
```shell
# generate key
$ ./sshkey-mgr-admin gen <name>
# follow the hint 
# 1. enter the passphrase of your ssh key
# 2. enter the user name of your server
# 3. enter the ip of your server


# list the key(s)
$ ./sshkey-mgr-admin list
test/
├── test
├── test.conf
└── test.pub

0 directories, 3 files
```


## Deploy the ssh configuration 
### host

```shell
$ ./sshkey-mgr-admin deploy-c <name>
```
This action deploys `<name>` ssh configuration to your host.

### server

```shell
$ ./sshkey-mgr-admin deploy-s <name>
```
This action sends the public key to server.

After those two action, you can ssh to you server with the command below:
```shell
$ ssh <name>
```

For example, you have just generated a key name `test` successfully and you want to deploy the key to your host and server: 
```shell
$ ./sshkey-mgr-admin deploy-c test
$ ./sshkey-mgr-admin deploy-s test
$ ssh test
```


## Restore the configuration
### host
```shell
$ ./sshkey-mgr-admin restore-c <name>
```
This action deletes the ssh related configuration in `~/.ssh/config.d/` 

### server
```shell
$ ./sshkey-mgr-admin restore-s <name>
```
This action removes the public key in server.

    

## List the existed keys
```shell
$ ./sshkey-mgr-admin list
```


## Upload ssh key from host to remote
This action uploads the key `<name>` from your host to `<storage>` by using scp command.
```shell
$ ./sshkey-mgr-admin upload <name> <storage>
```

For example, you have generate a key named `test` and you want to backup it to `xiaoming@192.168.20.1:~/sshkey-storage/`:
```shell
$ ./sshkey-mgr-admin upload test xiaoming@192.168.20.1:~/sshkey-storage/
``` 

>The purpose we design this feature is to provide an interface to share the key with others or just backup your key(s). By using this sub-command, you can send the key to one's machine or a file share system such as Samba.

## Fetch ssh key from remote
This action fetchs the specified directory `<name>` from `<storage>` to your host.
```shell
$ ./sshkey-mgr-admin fetch <storage> <name>/all 
```

For example:

* You want to fetch the ssh key named `test` in `xiaoming@192.168.20.1:~/sshkey-storage/`
    ```shell
    $ ./sshkey-mgr-admin update xiaoming@192.168.20.1:~/sshkey-storage/ test
    ```
* You want to fetch all the ssh key in `xiaoming@192.168.20.1:~/sshkey-storage/` 
    ```shell
    $ ./sshkey-mgr-admin update xiaoming@192.168.20.1:~/sshkey-storage/ all
    ```

# For user

## Fetch ssh key from remote
This action fetch the specified `<name>` directory from `<storage>` to your host.
```shell
$ ./sshkey-mgr-user update <storage> <name>/all
```

For example:

* You want to fetch the ssh key named `test` in `xiaoming@192.168.20.1:~/sshkey-storage/`
    ```shell
    $ ./sshkey-mgr-user update xiaoming@192.168.20.1:~/sshkey-storage/ test
    ```
* You want to fetch all the ssh key in `xiaoming@192.168.20.1:~/sshkey-storage/` 
    ```shell
    $ ./sshkey-mgr-user update xiaoming@192.168.20.1:~/sshkey-storage/ all
    ```

## Deploy the ssh configuration

```shell
$ ./sshkey-mgr-user deploy-c <name>
```
This action deploys `<name>` ssh configuration on your host.

After this action, you can ssh to you server.
```shell
$ ssh <name>
```
    
For example, you want to deploy the key `test`: 
```shell
$ ./sshkey-mgr-user deploy-c test
$ ssh test
```


## Restore the configuration
```shell
$ ./sshkey-mgr-user restore-c <name>
```
This action deletes the ssh related configuration in `~/.ssh/config.d/`.

    
## List the existed keys
```shell
$ ./sshkey-mgr-user list
```


# Advanced
1. autocomplete

    According to my research, openssh seems not support autocomplete of your Host name in ssh configuration. So we provide a script to config the autocomplete.
    ```shell
    $ cd autocomplete/
    $ ./autocomplete.sh
    ```

    This needs the sudo permission to copy configuration file `ssh` to `/etc/bash_completion.d/`.
    After running the script, you need to open another terminal to check whether it is work.

    > For more information about autocomplete configuration, see [here](https://debian-administration.org/article/317/An_introduction_to_bash_completion_part_2)
