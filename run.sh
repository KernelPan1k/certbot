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

  if [ "${expand}" == "true" ]; then

     if [ -z ${distinct+x} ]; then
       certbot certonly --verbose --noninteractive --quiet --standalone --agree-tos --email="${email}" --expand -d "${domains}" "$@";
     else
        IFS=',' read -ra ADDR <<< "$domains"
        for domain in "${ADDR[@]}"; do
          certbot certonly --verbose --noninteractive --quiet --standalone --agree-tos --email="${email}" --expand -d "${domain}" "$@";
        done
     fi

  else

    if [ -z ${distinct+x} ]; then
      certbot certonly --verbose --noninteractive --quiet --standalone --agree-tos --email="${email}" -d "${domains}" "$@";
    else
      IFS=',' read -ra ADDR <<< "$domains"
      for domain in "${ADDR[@]}"; do
        certbot certonly --verbose --noninteractive --quiet --standalone --agree-tos --email="${email}" -d "${domain}" "$@";
      done
    fi
  fi

else
  certbot renew "$@"
fi
