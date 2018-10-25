#!/usr/bin/env bash

if [ -z ${renew+x} ]; then

  if [ -z ${email+x} ]; then
    echo "Fatal: administrator email address must be specified with the environment variable named 'email'";
    exit 1;
  fi

  if [ -z ${domains+x} ]; then
    echo "Fatal: domains must be specified with the environment variable named 'domains'";
    exit 1;
  fi

  expand_domains=""

  if [ "${expand}" == "true" ]; then
    expand_domains="--expand"
  fi

  if [ -z ${distinct+x} ]; then

    certbot certonly --verbose --noninteractive --quiet --standalone --agree-tos --email="${email}" "${expand_domains}" -d "${domains}" "$@";

   else

    IFS=',' read -ra ADDR <<< "$domains"
    for domain in "${ADDR[@]}"; do
        certbot certonly --verbose --noninteractive --quiet --standalone --agree-tos --email="${email}" "${expand_domains}" -d "${domain}" "$@";
    done

  fi;
  else

  certbot renew "$@"

fi
