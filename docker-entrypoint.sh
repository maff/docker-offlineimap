#!/bin/bash

set -eu

if [ "$(id docker -u)" != "${UID}" ]; then
  echo "INFO: Changing 'docker' UID to '${UID}'"
  usermod -o -u ${UID} docker
fi

if [ "$(id docker -g)" != "${GID}" ]; then
  echo "INFO: Changing 'docker' GID to '${GID}'"
  groupmod -o -g ${GID} docker
fi

gosu docker /usr/bin/offlineimap "$@"
