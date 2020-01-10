# `docker-offlineimap`

A docker image providing `offlineimap` based on `debian:stable`.

## Usage

To run `offlineimap` with your specific configuration, mount a config file to `/home/docker/.offlineimaprc`. A volume `/target` is exposed and can be used as mail destination.

```shell
$ docker run -it --rm \
  -v /path/to/offlineimaprc:/home/docker/.offlineimaprc:ro
  -v /path/to/target:/target \
  maff/offlineimap
```

An example `offlineimaprc`:

```
[general]
# make sure to map metadata to the mounted volume
metadata = /target/metadata
accounts = example

[Account example]
localrepository = example_local
remoterepository = example_remote

[Repository example_local]
type = Maildir
localfolders = /target/data

[Repository example_remote]
sslcacertfile = /etc/ssl/certs/ca-certificates.crt
type = IMAP
readonly = True
remotehost = mail.example.com
remoteuser = username
remotepass = password
```

See [offlineimap's documentation](http://www.offlineimap.org/doc/quick_start.html) for more config file examples.

## Customizing UID/GID

By default, the container executes `offlineimap` as `docker` user with UID/GID set to `9000`. If you want to customize the user's UID to match your permissions, you can pass `UID` and `GID` as environment variables:

```shell
$ docker run -it --rm \
  -e UID=9500 \
  -e GID=9500 \
  -v /path/to/offlineimaprc:/home/docker/.offlineimaprc:ro \
  -v /path/to/target:/target \
  maff/offlineimap

INFO: Changing 'docker' UID to '9500'
INFO: Changing 'docker' GID to '9500'
```
